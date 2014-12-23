import Primes
import Control.Monad
import System.Environment
import System.Random
import System.IO

fib :: [Integer] 
fib = 1 : 1 : zipWith (+) fib (tail fib)

simpleConcat       x y = read $ show x ++ show y
reversedConcat     x y = read $ (reverse $ show y) ++ show x
semireversedConcat x y = read $ show y ++ show x

main = do
    args <- getArgs
    let limit = if "-limit" `elem` args
                then read (head $ drop 1 $ dropWhile (/= "-limit") args)
                else 1000
        concat | "-reversed"     `elem` args = reversedConcat 
               | "-semireversed" `elem` args = semireversedConcat
               | otherwise                   = simpleConcat
        verbose = "-verbose" `elem` args
    hSetBuffering stdout NoBuffering
    seed <- newStdGen
    forM_ (takeWhile (< 10^limit) $ scanl concat (head fib) (tail fib)) $ \x -> do
        when (isPrime seed x) $ putStrLn $ show x
        when verbose $ putStrLn $ "Checked all up to 10^" ++ show ((length $ show x) - 1) ++ "..."
