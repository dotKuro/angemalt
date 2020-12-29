module Angemalt.Lib.Maps.Channel ( channelMap ) where

import Angemalt.Lib.Channel ( Channel )
import Angemalt.Lib.Color ( Color(..) )

channelMap :: [(String, Color -> Channel)]
channelMap =
    [ ("red", red)
    , ("green", green)
    , ("blue", blue)
    , ("alpha", alpha)
    ]
