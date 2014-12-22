import Primes
import Control.Monad
import System.Environment
import System.Random
import System.IO

fib :: [Integer] 
fib = 1 : 1 : zipWith (+) fib (tail fib)

forwardConcat x y = read $ show x ++ show y
reverseConcat x y = read $ (reverse $ show y) ++ show x

main = do
    mode <- getArgs
    let concat = case mode of
            ("reverse":_) -> reverseConcat
            otherwise     -> forwardConcat
    hSetBuffering stdout NoBuffering
    seed <- newStdGen
    forM_ (scanl concat (head fib) (tail fib)) $ \x -> do
        when (isPrime seed x) $ putStrLn $ show x ++ " is a Fibonacci concat prime!"
        putStrLn $ "Checked all up to 10^" ++ show ((length $ show x) - 1) ++ "..."
