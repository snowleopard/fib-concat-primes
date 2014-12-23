import Primes
import Control.Monad
import System.Environment
import System.Random
import System.IO

fib :: [Integer] 
fib = 1 : 1 : zipWith (+) fib (tail fib)

forwardConcat     x y = read $ show x ++ show y
reverseConcat     x y = read $ (reverse $ show y) ++ show x
semireverseConcat x y = read $ show y ++ show x

main = do
    args <- getArgs
    let limit = if "-limit" `elem` args
                then read (head $ drop 1 $ dropWhile (/= "-limit") args)
                else 1000
        concat | "-reverse"     `elem` args = reverseConcat 
               | "-semireverse" `elem` args = semireverseConcat
               | otherwise                  = forwardConcat
        verbose = "-verbose" `elem` args
    hSetBuffering stdout NoBuffering
    seed <- newStdGen
    forM_ (takeWhile (< 10^limit) $ scanl concat (head fib) (tail fib)) $ \x -> do
        when (isPrime seed x) $ putStrLn $ show x
        when verbose $ putStrLn $ "Checked all up to 10^" ++ show ((length $ show x) - 1) ++ "..."
