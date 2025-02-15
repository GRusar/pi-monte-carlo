{-# LANGUAGE NumericUnderscores #-}

module Parallels (main) where

import Control.Monad
import System.Random.MWC (createSystemRandom, uniform)
import Control.Parallel.Strategies (parListChunk, using, rdeepseq)
import qualified Data.Vector.Unboxed as V
import System.Random.Stateful (Uniform(..))

chunkSize :: Int
chunkSize = 10_000_000  -- Оптимальный размер чанка

main :: Double -> IO ()
main count = do
    let numSamples = round count :: Int
    insideCount <- countInsideCircle numSamples
    print (4 * fromIntegral insideCount / fromIntegral numSamples)

countInsideCircle :: Int -> IO Int
countInsideCircle n = do
    let chunks = n `div` chunkSize
    results <- forM [1 .. chunks] $ \_ -> countChunk chunkSize
    return $ sum results  -- Чистая сумма всех результатов

countChunk :: Int -> IO Int
countChunk n = do
    gen <- createSystemRandom
    -- Генерация случайных чисел
    xs <- V.replicateM n (uniform gen :: IO Double)
    ys <- V.replicateM n (uniform gen :: IO Double)
    let inside = V.zipWith (\x y -> if x*x + y*y <= 1.0 then 1 else 0) xs ys
    return $ parSum inside  -- Параллельная сумма

parSum :: V.Vector Int -> Int
parSum vec = sum (V.toList vec `using` parListChunk 1000 rdeepseq)