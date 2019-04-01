
-- Testing Parsing

import JsontyperParser
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Jsontyper" $ do

    it "parses a simple key-value JSON" $ do
        parseJson "{ \"sampleKey\": \"sampleValue\" }" `shouldBe` JsonObject [("sampleKey", JsonString "samplevalue")]
