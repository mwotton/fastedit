{-# LANGUAGE TupleSections #-}
module Text.FastEdit where

import           BasePrelude
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.HashMap.Strict        as HM
import qualified Data.HashSet               as HS
import qualified Data.Sequence              as Seq
import           Prelude                    ()
import           Safe                       (atMay)

cantorise :: (a -> b -> [c]) -> [a] -> [b] -> [c]
cantorise f as bs = concat $ mapMaybe
                    (\(ai,bi) -> do
                        a <- atMay as ai
                        b <- atMay bs bi
                        return $ f a b) antiDiagonals

antiDiagonals :: [(Int, Int)]
antiDiagonals = concatMap anti [0..]
  where anti n = zip [0..n] (reverse [0..n])

buildDict :: Int -> [String] -> String -> [String]
buildDict n dictWords = \s -> nub $ cantorise dostuff (deletions s) dicts
  where
    dostuff candidates dict = concat $ mapMaybe (`HM.lookup` dict) candidates

    dicts = map (fmap HS.toList . builder) $ transpose $ map (take n . tagged) dictWords

    builder = HM.fromListWith (HS.union) . concatMap foo

    foo (a,as) = map (,HS.singleton a) as


tagged s = (map (s,) (deletions s))

deletions :: String -> [[BL.ByteString]]
deletions s = map (ordNub . deleteN s) [0..(length s)]

deleteN :: String -> Int -> [BL.ByteString]
deleteN s n = map BL.pack $ toList $ go s n
  where
    go :: String -> Int -> Seq.Seq String
    go s 0 = Seq.singleton s
    go (x:xs) n = go xs (n-1) <> fmap (x:) (go xs n)
    go [] _ = Seq.empty


ordNub l = go HS.empty l
  where
    go _ [] = []
    go s (x:xs) = if x `HS.member` s then go s xs
                  else x : go (HS.insert x s) xs
