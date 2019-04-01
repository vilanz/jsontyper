module Main where

import qualified JsontyperParser as JParser

main :: IO ()
main = do
    putStrLn $ "Insert JSON to convert (if nothing is inputted, a sample JSON is used)"
    jsonInput <- getLine
    let rawJson = if jsonInput == ""
        then "{ \"key1\": \"str1\", \"key2\": { \"arr1\": [ 1, 2, 3 ] } }"
        else jsonInput
    putStrLn $ JParser.parseJson rawJson