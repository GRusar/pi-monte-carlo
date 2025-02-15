{-# LANGUAGE NumericUnderscores #-}
module Main (main) where

import qualified Old
import qualified Parallels

old = True
count = 100_000_000

main :: IO ()
main = do
  if old 
    then Old.main count
    else Parallels.main count