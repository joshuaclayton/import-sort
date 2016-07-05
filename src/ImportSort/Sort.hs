module ImportSort.Sort
    ( sortImport
    ) where

import qualified Data.List as L
import qualified ImportSort.Parser as P
import qualified ImportSort.Types as T

sortImport :: String -> String
sortImport s =
    either (const s) (L.intercalate "\n" . map show . T.sortedImports) $ P.parseImports s
