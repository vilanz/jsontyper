
module JsontyperParser (
    parseJsonObject,
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

data JsonValue = JsonString String
                | JsonNumber Int
                | JsonObject [(String, JsonValue)]
                | JsonArray [JsonValue]
                deriving (Show, Eq)

betweenMany :: Parser a -> Parser b -> Parser c -> Parser b
betweenMany l val r = (l >> spaces) *> val <* (r >> spaces)

parseJsonNumber :: Parser JsonValue
parseJsonNumber = do
    spaces
    numberStr <- many digit
    spaces
    return $ JsonNumber (read numberStr :: Int)

parseJsonString :: Parser JsonValue
parseJsonString = JsonString <$> betweenMany (string "\"") (many (noneOf "\":")) (string "\"")

parseJsonArray :: Parser JsonValue
parseJsonArray = JsonArray <$> betweenMany (string "[") values (string "]")  
    where values = parseJson `sepBy` char ','

parseJsonObject :: Parser JsonValue
parseJsonObject = JsonObject <$> betweenMany (string "{") keyValues (string "}")
    where
        keyValues = kv `sepBy` char ','
        kv = do
            -- TODO handle spaces better 
            spaces
            JsonString key <- parseJsonString
            char ':'
            spaces
            val <- parseJson
            return (key, val)

parseJson :: Parser JsonValue
parseJson = choice [parseJsonArray, parseJsonObject, parseJsonString, parseJsonNumber]
    
magicallyParseItAll :: String -> String
magicallyParseItAll input = case (parse parseJson "" input) of
    Left e -> "Parse error: " ++ show e
    Right json -> show json

