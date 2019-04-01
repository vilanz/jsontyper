module JsontyperTerminal (
    readJsonFile
) where

import System.Environment

readJsonFile :: IO String
readJsonFile = do
    [ filename ] <- getArgs
    readFile filename