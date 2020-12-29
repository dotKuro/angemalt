module Angemalt.Lib.Theme ( Theme, parseTheme ) where

import Angemalt.Lib.Color ( Color )
import Angemalt.Lib.Error ( Error(..)
             , Result
             , failure
             )

import Data.Aeson (decode)
import Data.Map (Map, toList)
import qualified Data.ByteString.Lazy.Char8 as BS

type Theme = [(String, Color)]

parseTheme :: String -> Result Theme
parseTheme unparsedTheme = 
    case decode (BS.pack unparsedTheme) :: Maybe (Map String Color) of
        Just theme -> return (toList theme)
        Nothing -> failure UnableToParseColor 
