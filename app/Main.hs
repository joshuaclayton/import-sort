module Main where

import qualified ImportSort.Sort as S

main :: IO ()
main = getContents >>= putStrLn . S.sortImport
