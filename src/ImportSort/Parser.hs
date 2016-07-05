{-# LANGUAGE OverloadedStrings #-}

module ImportSort.Parser
    ( parseImports
    ) where

import           Data.Attoparsec.Text
import qualified Data.Text as T
import           ImportSort.Types (ModuleImport(ModuleImport))

parseImports :: String -> Either String [ModuleImport]
parseImports = parseOnly (importsParser <* endOfInput) . T.pack

importsParser :: Parser [ModuleImport]
importsParser = many' $ moduleImportParser <* endOfLine

moduleImportParser :: Parser ModuleImport
moduleImportParser =
    "import" *> skipSpace *> (
        ModuleImport
        <$> option False (const True <$> string "qualified") <* skipSpace
        <*> takeTill isEndOfLine
        )
