{-# LANGUAGE NumericUnderscores #-}

module Old (main) where

import System.Random

main :: Double -> IO ()
main count = do
  p <- sum <$> mapM (\_ -> calcPinSector) [1..count]
  print (4 * p / count)

calcPinSector = do
  x <- randomIO :: IO Double
  y <- randomIO :: IO Double

  return $! if sqrt(x * x + y * y) <= 1 then 1 else 0