import Development.Shake
import Development.Shake.FilePath

target = "fibConcatPrimes" <.> exe
primes = "Primes" </> "Primes.hs"

main = shakeArgs shakeOptions{shakeFiles="_build/"} $ do
    want [target]

    "clean" ~> do
        putNormal "Cleaning files in _build"
        removeFilesAfter "." [target, "_build//*", "//*.hi", "//*.o"]

    target %> \out -> do
        let src = out -<.> "hs"
        need [src, primes]
        cmd "ghc" ["-O2", "-i" ++ takeDirectory primes, src]

