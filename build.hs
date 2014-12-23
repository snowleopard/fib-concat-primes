import Development.Shake
import Development.Shake.FilePath

target = "fibConcatPrimes" <.> exe
primes = "Primes" </> "Primes.hs"
results = "fibConcatPrimes.txt"
reverseResults = "reverseFibConcatPrimes.txt"


main = shakeArgs shakeOptions{shakeFiles="_build/"} $ do
    want [target, results, reverseResults]

    "clean" ~> do
        putNormal "Cleaning files in _build"
        removeFilesAfter "." [target, "_build//*", "//*.hi", "//*.o"]

    target %> \out -> do
        let src = out -<.> "hs"
        need [src, primes]
        cmd "ghc" ["-O2", "-i" ++ takeDirectory primes, src]

    results %> \out -> do
        need [target]
        Stdout res <- cmd target
        writeFileChanged out res

    reverseResults %> \out -> do
        need [target]
        Stdout res <- cmd target ["-reverse"]
        writeFileChanged out res
