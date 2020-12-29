module Angemalt.Lib.Util ( anyFromString
                         , lookupEither
                         , mapRatioUpTo
                         , readHex
                         , roundByDigit
                         ) where

import Angemalt.Lib.Error ( Result, Error, failure )

import Data.Either ( isRight )
import qualified Numeric as N


lookupEither :: Eq tKey => tKey -> [(tKey, tValue1)] -> [(tKey, tValue2)] -> Maybe (Either tValue1 tValue2)
lookupEither key values1 values2 =
    case lookup key values1 of
        Just value -> Just $ Left value
        Nothing ->
            case lookup key values2 of
                Just value -> Just $ Right value
                Nothing -> Nothing 

readHex :: String -> Maybe Int
readHex hexString =
    case N.readHex hexString of
        [(value, "")] -> Just value
        _ -> Nothing 

anyFromString :: [String -> Result a] -> Error -> String -> Result a
anyFromString parsers err string =
    case filter isRight $ map ($string) parsers of
        [a] -> a
        _:_:_ -> error "More than one parser was able to parse the same string successfully. This should not happen."
        [] -> failure err

mapRatioUpTo :: Int -> Rational -> Int
mapRatioUpTo limit ratio = round (ratio * fromIntegral limit)

roundByDigit :: Int -> Rational -> Rational
roundByDigit digits number =
    fromIntegral  (mapRatioUpTo (10 ^ digits) number) / (10 ^ digits)
