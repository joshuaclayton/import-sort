module ImportSort.Types
    ( ModuleImport(ModuleImport)
    , sortedImports
    ) where

import           Data.Text (Text)
import qualified Data.Text as T
import qualified Data.List as L

data ModuleImport = ModuleImport Bool Text

instance Show ModuleImport where
    show (ModuleImport qualified value) = "import " ++ (if qualified then "qualified" else "         ") ++ " " ++ T.unpack value

sortedImports :: [ModuleImport] -> [ModuleImport]
sortedImports = L.sortBy sortModuleImport

sortModuleImport :: ModuleImport -> ModuleImport -> Ordering
sortModuleImport (ModuleImport _ a) (ModuleImport _ b) = compare a b
