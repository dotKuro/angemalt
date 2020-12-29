module Angemalt.Lib.Maps.ColorFormat ( colorFormatMap ) where

import Angemalt.Lib.Color ( Color
             , rgbLongHex
             , rgbLongHexCapatalized
             , rgbShortHex
             , rgbShortHexCapatalized
             , rgbaLongHex
             , rgbaLongHexCapatalized
             , rgbaShortHex 
             , rgbaShortHexCapatalized
             )

colorFormatMap :: [(String, Color -> String )]
colorFormatMap =
    [ ("rrggbb", rgbLongHex)
    , ("RRGGBB", rgbLongHexCapatalized)
    , ("rgb", rgbShortHex)
    , ("RGB", rgbShortHexCapatalized)
    , ("rrggbbaa", rgbaLongHex)
    , ("RRGGBBAA", rgbaLongHexCapatalized)
    , ("rgba", rgbaShortHex)
    , ("RGBA", rgbaShortHexCapatalized)
    ]
