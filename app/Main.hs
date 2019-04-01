module Main where

import qualified JsontyperParser   as JParser
import qualified JsontyperTerminal as JTerm

main :: IO ()
main = do
    rawJson <- JTerm.readJsonFile
    putStrLn rawJson