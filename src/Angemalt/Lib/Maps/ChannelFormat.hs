module Angemalt.Lib.Maps.ChannelFormat ( channelFormatMap ) where

import Angemalt.Lib.Channel ( Channel
             , longHex
             , longHexCapatalized
             , shortHex
             , shortHexCapatalized
             , channelRatio
             , channelAbsolute
             )

channelFormatMap :: [(String, Channel -> String )]
channelFormatMap =
    [ ("hex", longHex)
    , ("HEX", longHexCapatalized)
    , ("hexShort", shortHex)
    , ("HEXShort", shortHexCapatalized)
    , ("ratio", channelRatio)
    , ("absolute", channelAbsolute)
    ]