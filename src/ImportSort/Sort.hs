module ImportSort.Sort
    ( sortImport
    ) where

import qualified Data.List as L
import qualified Data.Text as T
import qualified ImportSort.Parser as P
import           ImportSort.Types (ModuleImport(ModuleImport), sortedImports)

sortImport :: String -> String
sortImport s =
    either (const s) (L.intercalate "\n" . renderImports . sortedImports) $ P.parseImports s

renderImports :: [ModuleImport] -> [String]
renderImports is =
    map (renderImport anyQualified) is
  where
    anyQualified = any qualifiedPresent is
    qualifiedPresent (ModuleImport v _) = v

renderImport :: Bool -> ModuleImport -> String
renderImport anyQualified (ModuleImport qualified value) =
    "import " ++ qual ++ T.unpack value
  where
    qual = case (anyQualified, qualified) of
        (False, _) -> ""
        (_, True)  -> "qualified "
        (_, False) -> "          "
