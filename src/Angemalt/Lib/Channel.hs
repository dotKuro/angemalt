module Angemalt.Lib.Channel ( Channel(..)
                            , channelFromByte
                            , maxChannel 
                            , longHex 
                            , longHexCapatalized
                            , shortHex
                            , shortHexCapatalized
                            , channelRatio
                            , channelAbsolute
                            , channelFromString
                            ) where


import Angemalt.Lib.Error ( Error(..), Result )
import Angemalt.Lib.Util ( anyFromString, mapRatioUpTo, readHex, roundByDigit )

import Data.Char ( toUpper )
import Numeric ( showHex )

newtype Channel = Channel Rational 

instance (Show Channel) where
    show = channelAbsolute

channelFromByte :: Int -> Result Channel
channelFromByte colorValue
    | 0 <= colorValue && colorValue <= 255 =
        Right $ Channel $ fromIntegral  colorValue / 255
    | otherwise =
        Left AbsoluteColorValuteNotBetween0and255 

maxChannel :: Channel
maxChannel = Channel 1

longHex :: Channel -> String 
longHex (Channel ratio) = 
    let
        nonPaddedHexString = showHex (mapRatioUpTo 255 ratio) ""
    in
        case length nonPaddedHexString of
            1 -> '0':nonPaddedHexString
            2 -> nonPaddedHexString
            _ -> error "Hex string with 3 or more digits was created. This should never happen."

longHexCapatalized :: Channel -> String 
longHexCapatalized = map toUpper  . longHex

shortHex :: Channel -> String 
shortHex (Channel ratio) = 
    showHex (mapRatioUpTo 15 ratio) ""

shortHexCapatalized :: Channel -> String 
shortHexCapatalized = map toUpper  . shortHex

channelRatio :: Channel -> String
channelRatio (Channel ratio) = show (roundByDigit 2 ratio)

channelAbsolute :: Channel -> String
channelAbsolute (Channel ratio) = show $ mapRatioUpTo 255 ratio

channelFromString :: String -> Result Channel
channelFromString = anyFromString parsers UnableToParseChannel 

parsers :: [String -> Result Channel]
parsers = [fromLongHex]

fromLongHex :: String -> Result Channel
fromLongHex hexString = maybe (Left UnableToParseColor) channelFromByte (readHex hexString)