module Angemalt.Lib.Color ( Color(..)
                          , rgbLongHex
                          , rgbLongHexCapatalized
                          , rgbShortHex
                          , rgbShortHexCapatalized
                          , rgbaLongHex
                          , rgbaLongHexCapatalized
                          , rgbaShortHex
                          , rgbaShortHexCapatalized
                          , colorFromString ) where

import Angemalt.Lib.Channel ( Channel(..), channelFromString, maxChannel )
import qualified Angemalt.Lib.Channel as Channel ( longHex, shortHex )
import Angemalt.Lib.Error ( Error(..), Result )
import Angemalt.Lib.Util ( anyFromString )

import Data.Aeson ( FromJSON(..), withText )
import Data.Char ( toUpper )
import Data.List.Split ( chunksOf )
import Data.Text ( unpack )

data Color = Color { red :: Channel
                   , green :: Channel
                   , blue :: Channel
                   , alpha :: Channel
                   }

instance (FromJSON Color) where
    parseJSON  = withText "Color" $ \colorString ->
        case colorFromString $ unpack colorString of
            Right color -> return color
            Left _ -> fail "Could not parse type Color."

instance (Show Color) where
    show = rgbLongHex

rgbLongHex :: Color -> String
rgbLongHex Color{ red=r, green=g, blue=b } = '#' : concatMap Channel.longHex [r, g, b]

rgbLongHexCapatalized :: Color -> String 
rgbLongHexCapatalized = map toUpper . rgbLongHex

rgbShortHex :: Color -> String
rgbShortHex Color{ red=r, green=g, blue=b } = '#' : concatMap Channel.shortHex [r, g, b]

rgbShortHexCapatalized :: Color -> String 
rgbShortHexCapatalized = map toUpper . rgbShortHex

rgbaLongHex :: Color -> String
rgbaLongHex Color{ red=r, green=g, blue=b, alpha=a } = '#' : concatMap Channel.longHex [r, g, b, a]

rgbaLongHexCapatalized :: Color -> String 
rgbaLongHexCapatalized = map toUpper . rgbaLongHex

rgbaShortHex :: Color -> String
rgbaShortHex Color{ red=r, green=g, blue=b, alpha=a } = '#' : concatMap Channel.shortHex [r, g, b, a]

rgbaShortHexCapatalized :: Color -> String 
rgbaShortHexCapatalized = map toUpper . rgbaShortHex

colorFromString :: String -> Result Color
colorFromString = anyFromString parsers UnableToParseColor 

parsers :: [String -> Result Color]
parsers = [ colorFromLongHex, colorFromLongHexWithAlpha ]

colorFromLongHex :: String -> Result Color
colorFromLongHex ('#':colorValues) =
    case chunksOf 2 colorValues of
        [rr, gg, bb] -> do
            r <- channelFromString rr
            g <- channelFromString gg
            b <- channelFromString bb
            return $ Color { red = r
                  , green = g
                  , blue = b
                  , alpha = maxChannel  }
        _ -> Left UnableToParseColor
colorFromLongHex _ = Left UnableToParseColor

colorFromLongHexWithAlpha :: String -> Result Color
colorFromLongHexWithAlpha ('#':colorValues) =
    case chunksOf 2 colorValues of
        [rr, gg, bb, aa] -> do
            r <- channelFromString rr
            g <- channelFromString gg
            b <- channelFromString bb
            a <- channelFromString aa
            return $ Color { red = r
                  , green = g
                  , blue = b
                  , alpha = a }
        _ -> Left UnableToParseColor
colorFromLongHexWithAlpha _ = Left UnableToParseColor