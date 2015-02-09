{-# LANGUAGE ScopedTypeVariables, TemplateHaskell #-}
module Text.FastEditSpec where

import           BasePrelude
import qualified Data.ByteString.Char8 as BS
import           Data.FileEmbed
import           Prelude               ()
import           Test.Hspec
import           Test.QuickCheck
import           Text.EditDistance
import           Text.FastEdit

dict = $(embedFile "/usr/share/dict/words")

neighbours = buildDict 2 . map BS.unpack  $ BS.lines dict

newtype ReasonableString = ReasonableString String
  deriving (Show, Eq)

instance Arbitrary ReasonableString where
  arbitrary = ReasonableString <$> arbitrary `suchThat` (\s -> length s < 20)

spec = describe "fastedit" $ do
  it "has a result on a word" $ do
    (`mapM_` ["gold","cake"]) $ \w -> do
      let n = take 10 $ neighbours w
      print n
      (length n > 0) `shouldBe` True
  it "works the same as Text.EditDistance" $ do
    -- we don't accurately model substitutions. if this behaviour is
    -- desired, it's probably easier to

    let editCosts = defaultEditCosts { substitutionCosts = ConstantCost 1000 }
    property $
      \(ReasonableString s) ->
        let n = take 3 (neighbours s)
            distances = map (\x -> (x,levenshteinDistance editCosts s x)) n in
        (s,distances,n) `shouldBe` (s,sortBy (comparing snd) distances, n)
