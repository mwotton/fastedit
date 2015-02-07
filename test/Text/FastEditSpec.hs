{-# LANGUAGE ScopedTypeVariables, TemplateHaskell #-}
module Text.FastEditSpec where

import           BasePrelude
import qualified Data.ByteString.Char8 as BS
import           Data.FileEmbed
import           Prelude               ()
import           Test.Hspec
import           Test.QuickCheck       (property)
import           Text.EditDistance
import           Text.FastEdit

dict = $(embedFile "/usr/share/dict/words")

neighbours = buildDict 3 . map BS.unpack  $ BS.lines dict

spec = describe "fastedit" $ do
  it "has a result on a word" $ do
    length (neighbours "gold") > 0
  it "works the same as Text.EditDistance" $ do

    property $
      \(s::String) ->

        all (\(i, other) -> levenshteinDistance defaultEditCosts other s == i ) (neighbours s)
