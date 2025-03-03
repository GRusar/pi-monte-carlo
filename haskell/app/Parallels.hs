{-# LANGUAGE NumericUnderscores #-}

module Parallels (main) where

import Control.Monad
import System.Random.MWC (createSystemRandom, uniform, GenIO)
import qualified Data.Vector.Unboxed as V

chunkSize :: Int
chunkSize = 10_000_000  -- Оптимальный размер чанка

main :: Double -> IO ()
main count = do
    let numSamples = round count :: Int
    gen <- createSystemRandom  -- Создаем генератор один раз
    insideCount <- countInsideCircle gen numSamples
    print (4 * fromIntegral insideCount / fromIntegral numSamples)

countInsideCircle :: GenIO -> Int -> IO Int
countInsideCircle gen n = do
    let chunks = n `div` chunkSize
    results <- forM [1 .. chunks] $ \_ -> countChunk gen chunkSize
    return $ sum results  -- Чистая сумма всех результатов

countChunk :: GenIO -> Int -> IO Int
countChunk gen n = do
    -- Генерация случайных чисел
    xs <- V.replicateM n (uniform gen :: IO Double)
    ys <- V.replicateM n (uniform gen :: IO Double)
    let inside = V.zipWith (\x y -> if sqrt(x*x + y*y) <= 1.0 then 1 else 0) xs ys
    return $ V.sum inside  -- Оптимизированная параллельная сумма