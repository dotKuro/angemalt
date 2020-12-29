module Angemalt.Lib.Error ( Result
             , Error(..)
             , failure
             ) where
             
type Result = Either Error

failure :: Error -> Result a
failure = Left

data Error = 
    UnrecognizedColorPattern
    | ColorDoesNotExist
    | ChannelDoesNotExist
    | DisplayDoesNotExist
    | DisplayOrChannelDoesNotExist
    | AbsoluteColorValuteNotBetween0and255
    | UnableToParseColor
    | UnableToParseChannel
    | UnableToParseColorMap
    deriving ( Show )
