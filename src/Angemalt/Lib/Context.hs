module Angemalt.Lib.Context ( context ) where

import Angemalt.Lib.Error ( Error(..)
                          , Result
                          , failure
                          )
import Angemalt.Lib.Maps ( Maps(..) )
import Angemalt.Lib.Util ( lookupEither )

import Data.List.Split ( splitOn )
import Data.Text ( pack, unpack )
import Data.Text.Template ( ContextA )

context
  :: Maps
  -> ContextA Result
context maps colorTemplate =
    case splitOn "_" $ unpack colorTemplate of
        [colorName]                                 -> parseColorOnly colorName
        [colorName, formatOrChannelName]            -> parseColorWithProperty colorName formatOrChannelName
        [colorName, channelName, channelFormatName] -> parseChannelWithProperty colorName channelName channelFormatName
        _                                           -> failure UnrecognizedColorPattern
    where
        parseColorOnly colorName =
            case lookup colorName (theme maps) of
                Just color -> return $ pack (show color)
                Nothing    -> failure ColorDoesNotExist 
        
        parseColorWithProperty colorName formatOrChannelName =
            case ( lookup colorName (theme maps)
                 , lookupEither formatOrChannelName (channelMap maps) (colorFormatMap maps)
                 ) of
                    (Just color, Just (Left channel))      -> return $ pack $ show (channel color)
                    (Just color, Just (Right colorFormat)) -> return $ pack (colorFormat color)
                    (Nothing, _)                           -> failure ColorDoesNotExist 
                    (_, Nothing)                           -> failure DisplayOrChannelDoesNotExist 

        parseChannelWithProperty colorName channelName channelFormatName =
            case ( lookup colorName (theme maps)
                 , lookup channelName (channelMap maps)
                 , lookup channelFormatName (channelFormatMap maps)
                 ) of 
                     (Just color, Just channel, Just channelFormat) -> return $ pack $ channelFormat (channel color)
                     (Nothing, _, _)                                -> failure ColorDoesNotExist 
                     (_, Nothing, _)                                -> failure ChannelDoesNotExist 
                     (_, _, Nothing)                                -> failure DisplayDoesNotExist 