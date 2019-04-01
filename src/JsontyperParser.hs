
module JsontyperParser (
    parseString,
    magicallyParseItAll
) where

{- 
    {
        "id": "3",
        "cities": [
            "nowhereland",
            "timbó",
            "places"
        ],
        "options": {
            "tokenId": "ratonhoquetaun",
            "toggles": [1, 4, 16]
        }
    }

    TSONValue:
        TSONObject ("id", TSONString "3"),
        TSONArray ("cities", [ TSONString "nowhereland", TSONString "timbó", TSONString "places" ],
        TSONObject ("options", [
            TSONString ("tokenId", TSONValue: TSONString "ratonhoquetaun"),
            TSONArray ("toggles", [ TSONNumber 1, TSONNumber 4, TSONNumber 16 ])
        ]
-}

import Text.Parsec.String
import Text.Parsec.Char
import Text.Parsec.Combinator
import Text.Parsec.Error
import Text.Parsec.Prim

parseString :: Parser (String, String)
parseString = do
    char '\"'
    k <- many (noneOf "\"")
    char '\"'
    char ':'
    skipMany space
    char '\"'
    v <- many (noneOf "\"")
    char '\"'
    return (k, v)

data JSONValue = JSONString String
                | JSONNumber Int
                | JSONObject (String, JSONValue)
                | JSONArray [JSONValue]
                deriving (Show, Eq)

magicallyParseItAll :: String -> String
magicallyParseItAll input = case (parse parseString "(unknown)" input) of
    Left e -> "parse error: " ++ show e
    Right (k, v) -> "key: " ++ k ++ ", value: " ++ v

