
-- Testing Parsing

import qualified JsontyperParser as JParser

main :: IO ()
main = do
    putStrLn $ JParser.magicallyParseItAll "\"some sort of key\": \"a little value\""
