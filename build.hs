import Development.Shake
import Development.Shake.FilePath

target              = "_build" </> "fibConcatPrimes" <.> exe
primes              = "Primes" </> "Primes.hs"
results             = "fibConcatPrimes.txt"
reversedResults     = "reversedFibConcatPrimes.txt"
semireversedResults = "semireversedFibConcatPrimes.txt"

main = shakeArgs shakeOptions{shakeFiles="_build/"} $ do
    want [target, results, reversedResults, semireversedResults]

    "clean" ~> do
        putNormal "Clean up"
        removeFilesAfter "." ["_build//*", "//*.hi", "//*.o"]

    target %> \out -> do
        let src = takeFileName out -<.> "hs"
        need [src, primes]
        cmd "ghc" ["-O2", "-i" ++ takeDirectory primes, src, "-o", target]

    results %> \out -> do
        need [target]
        Stdout res <- cmd target
        writeFileChanged out res

    reversedResults %> \out -> do
        need [target]
        Stdout res <- cmd target ["-reversed"]
        writeFileChanged out res

    semireversedResults %> \out -> do
        need [target]
        Stdout res <- cmd target ["-semireversed"]
        writeFileChanged out res
