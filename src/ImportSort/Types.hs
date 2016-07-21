{-# LANGUAGE OverloadedStrings #-}

module ImportSort.Types
    ( ModuleImport(..)
    , sortedImports
    , miValue
    , miQualified
    ) where

import qualified Data.List as L
import qualified Data.List.Split as LS
import           Data.Text (Text)

data ModuleImport
    = QualifiedImport Text
    | NonQualifiedImport Text
    | Separator Text
    deriving Eq

sortedImports :: [ModuleImport] -> [ModuleImport]
sortedImports = concatMap sortedImports' . splitOn separators
  where
    sortedImports' = L.sortBy sortModuleImport
    splitOn = LS.split . LS.whenElt
    separators (Separator _) = True
    separators _ = False

sortModuleImport :: ModuleImport -> ModuleImport -> Ordering
sortModuleImport a b = compare (miValue a) (miValue b)

miValue :: ModuleImport -> Text
miValue (QualifiedImport t) = t
miValue (NonQualifiedImport t) = t
miValue (Separator t) = t

miQualified :: ModuleImport -> Bool
miQualified (QualifiedImport _) = True
miQualified _ = False
