module ImportSort.Types
    ( ModuleImport(ModuleImport)
    , sortedImports
    ) where

import           Data.Text (Text)
import qualified Data.List as L

data ModuleImport = ModuleImport Bool Text

sortedImports :: [ModuleImport] -> [ModuleImport]
sortedImports = L.sortBy sortModuleImport

sortModuleImport :: ModuleImport -> ModuleImport -> Ordering
sortModuleImport (ModuleImport _ a) (ModuleImport _ b) = compare a b
