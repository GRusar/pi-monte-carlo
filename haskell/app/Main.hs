{-# LANGUAGE NumericUnderscores #-}
module Main (main) where

import qualified Parallels as P
import qualified ParallelsImproved as PI
import System.Random

old = False
count = 100_000_000

main :: IO ()
main = do
  if old
    then oldMain count
    else PI.main count
    where
      oldMain :: Double -> IO ()
      oldMain counter = do
        p <- sum <$> mapM (const calcPinSector) [1..counter]
        print (4 * p / counter)
      calcPinSector = do
        x <- randomIO :: IO Double
        y <- randomIO :: IO Double
        return $! if sqrt (x * x + y * y) <= 1 then 1 else 0