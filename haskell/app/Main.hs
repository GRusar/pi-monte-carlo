{-# LANGUAGE NumericUnderscores #-}

module Main (main) where

import System.Random

main :: IO ()
main = do
  let count = 100_000_000
  p <- sum <$> mapM (\_ -> calcPinSector) [1..count]
  print (4 * p / count)

calcPinSector = do
  x <- randomIO :: IO Double
  y <- randomIO :: IO Double

  return $! if sqrt(x * x + y * y) <= 1 then 1 else 0


{-
import Control.Monad
import Control.Monad.Primitive (PrimMonad, PrimState)
import System.Random.MWC (createSystemRandom, uniform)
import Data.Vector.Unboxed (Vector)
import qualified Data.Vector.Unboxed as V
import Control.Parallel.Strategies (parListChunk, rdeepseq, using)

-- Число итераций
count :: Int
count = 100_000_000

-- Генерация случайных точек и вычисление попаданий в сектор
calcPinSector :: PrimMonad m => Int -> m Int
calcPinSector n = do
    gen <- createSystemRandom
    inSector <- forM [1..n] $ \_ -> do
        x <- uniform gen
        y <- uniform gen
        return $! if sqrt (x * x + y * y) <= 1.0 then 1 else 0
    return $! sum inSector

-- Параллельный запуск вычислений
main :: IO ()
main = do
    -- Разделяем работу на части для параллелизма
    let numChunks = 8  -- Можно изменить в зависимости от числа ядер
        chunkSize = count div numChunks
        chunks = replicate numChunks chunkSize

    -- Запуск вычислений в параллельных потоках
    results <- mapM calcPinSector chunks using parListChunk 2 rdeepseq

    -- Суммируем результаты
    let totalInSector = sum results
        piEstimate = 4.0 * fromIntegral totalInSector / fromIntegral count

    print piEstimate
-}

{-

import System.Random
import Control.Monad (replicateM)
import Data.List (foldl')

main :: IO ()
main = do
  let count = 100_000_000
  points <- replicateM count randomPoint
  let inSector = foldl' (\acc (x, y) -> if sqrt (x * x + y * y) <= 1 then acc + 1 else acc) 0 points
  let piApprox = 4 * (fromIntegral inSector / fromIntegral count)
  print piApprox

randomPoint :: IO (Double, Double)
randomPoint = do
  x <- randomIO
  y <- randomIO
  return (x, y)
-}
