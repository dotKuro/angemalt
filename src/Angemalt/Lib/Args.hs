module Angemalt.Lib.Args ( Args(..), args ) where

import Options.Applicative ( Parser
                           , strOption
                           , long
                           , short
                           , metavar
                           , help
                           , optional
                           ) 

data Args = Args { theme :: Maybe FilePath 
                 , input :: FilePath 
                 , output :: FilePath 
                 }

args :: Parser Args
args = Args
    <$> optional ( strOption
                 $ long "theme"
                 <> short 't'
                 <> metavar "THEME"
                 <> help "The path to the JSON theme file. Will default to $XDG_CONFIG_HOME/angemalt/theme.json"
                 )
    <*> strOption ( long "input"
                  <> short 'i'
                  <> metavar "TEMPLATE"
                  <> help "The path of the template to use."
                  )
    <*> strOption ( long "output"
                  <> short 'o'
                  <> metavar "OUTPUT"
                  <> help "The path where the substituted contents are saved."
                  )