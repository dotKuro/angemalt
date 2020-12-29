module Main where

import Angemalt ( angemalt )
import Angemalt.Lib.Args ( args )
import Options.Applicative( execParser
                          , header
                          , helper
                          , info
                          , (<**>)
                          )


main :: IO ()
main = angemalt =<< execParser opts
    where
        opts = 
            info (args <**> helper)
                $ header "angemalt - inecjt the same color theme in all your config files!"




