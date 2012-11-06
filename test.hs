module Main where
import Test.HUnit
import Answer

-- referring to source of words 
-- http://www.haskell.org/ghc/docs/latest/html/libraries/base-4.6.0.0/src/Data-List.html#words
split f s =
    case dropWhile f s of
         "" -> []
         s' -> w : words s''
               where (w, s'') = break f s'

doAssert [name, input, expected] =
    assertEqual name expected (solve input)

main :: IO ()
main =
    readFile "patterns.tsv"
    >>= return . lines
    >>= return . test . map (doAssert . split (== '\t'))
    >>= runTestTT
    >>  return ()

-- % runhaskell test.hs
-- ### Failure in: 1
-- #2
-- expected: "13245"
--  but got: "12345"
-- Cases: 3  Tried: 3  Errors: 0  Failures: 1
