module Angemalt.Lib.Maps ( Maps(..) ) where

import Angemalt.Lib.Theme ( Theme )
import Angemalt.Lib.Color ( Color )
import Angemalt.Lib.Channel ( Channel )

data Maps = Maps { theme :: Theme
                 , colorFormatMap :: [(String, Color -> String)]
                 , channelMap :: [(String, Color -> Channel )]
                 , channelFormatMap :: [(String, Channel -> String )]
                 }
