module ImportSort.Sort
    ( sortImport
    ) where

import qualified Data.List as L
import qualified Data.Text as T
import qualified ImportSort.Parser as P
import           ImportSort.Types

sortImport :: String -> String
sortImport s =
    either (const s) (L.intercalate "\n" . renderImports . sortedImports) $ P.parseImports s

renderImports :: [ModuleImport] -> [String]
renderImports is =
    map (renderImport anyQualified) is
  where
    anyQualified = any miQualified is

renderImport :: Bool -> ModuleImport -> String
renderImport _ (Separator t) = T.unpack t
renderImport anyQualified mi =
    "import " ++ qual ++ T.unpack (miValue mi)
  where
    qual = case (anyQualified, miQualified mi) of
        (False, _) -> ""
        (_, True)  -> "qualified "
        (_, False) -> "          "
