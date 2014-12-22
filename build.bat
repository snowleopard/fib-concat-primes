@mkdir _shake 2> nul
@ghc --make build.hs -rtsopts -with-rtsopts=-I0 -outputdir=_shake -o _shake/build && _shake\build --lint %*
