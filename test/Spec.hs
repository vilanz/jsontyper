
-- Testing Parsing

import qualified JsontyperParser as JParser

main :: IO ()
main = do
    putStrLn $ JParser.magicallyParseItAll "{ \"key1\": \"str1\", \"key2\": \"str2\" }"
