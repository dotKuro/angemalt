{-# LANGUAGE OverloadedStrings #-}

module Angemalt ( angemalt ) where

import qualified Angemalt.Lib.Args as Args ( Args(..) )
import Angemalt.Lib.Context ( context )
import qualified Angemalt.Lib.Maps as Maps ( Maps(..) )
import Angemalt.Lib.Maps.Channel ( channelMap )
import Angemalt.Lib.Maps.ChannelFormat ( channelFormatMap )
import Angemalt.Lib.Maps.ColorFormat ( colorFormatMap )
import Angemalt.Lib.Theme ( Theme, parseTheme )

import qualified Data.Text as T
import qualified Data.Text.Lazy as TL
import Data.Text.Template ( substituteA )
import System.Directory ( XdgDirectory(..), getXdgDirectory )
import System.FilePath ( (</>) )

angemalt :: Args.Args -> IO ()
angemalt args = do
    themePath <- getThemePath
    unparsedTheme <- readFile themePath
    template <- readFile $ Args.input args
    case parseTheme unparsedTheme of
        Right theme -> injectTheme theme template
        Left err -> print err
  where
    getThemePath :: IO FilePath
    getThemePath = 
        case Args.theme args of
            Just themePath -> return themePath
            Nothing -> getXdgDirectory XdgConfig $ "angemalt" </> "theme.json"
    injectTheme :: Theme -> String -> IO ()
    injectTheme theme template = do
        case substituteA (T.pack template) $ context (Maps.Maps theme colorFormatMap channelMap channelFormatMap ) of
            Right text -> writeFile (Args.output args) $ TL.unpack text
            Left err -> print err