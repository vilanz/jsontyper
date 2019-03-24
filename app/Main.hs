module Main where

import System.Environment

main :: IO ()
main = do
    [ filePath ] <- getArgs
    rawJson <- readFile filePath
    putStrLn rawJson