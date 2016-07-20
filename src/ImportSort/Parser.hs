{-# LANGUAGE OverloadedStrings #-}

module ImportSort.Parser
    ( parseImports
    ) where

import           Control.Applicative ((<|>))
import           Data.Attoparsec.Text
import           Data.Text (Text)
import qualified Data.Text as T
import           ImportSort.Types (ModuleImport(..))

parseImports :: String -> Either String [ModuleImport]
parseImports = parseOnly (importsParser <* endOfInput) . T.pack

importsParser :: Parser [ModuleImport]
importsParser = many' moduleImportParser

moduleImportParser :: Parser ModuleImport
moduleImportParser =
    qualifiedImportParser
    <|> nonQualifiedImportParser
    <|> separatorParser

qualifiedImportParser :: Parser ModuleImport
qualifiedImportParser = do
    "import" *> skipSpace *> "qualified" *> skipSpace
    QualifiedImport <$> importTextParser <* endOfLine

nonQualifiedImportParser :: Parser ModuleImport
nonQualifiedImportParser = do
    "import" *> skipSpace
    NonQualifiedImport <$> importTextParser <* endOfLine

separatorParser :: Parser ModuleImport
separatorParser = endOfLine *> pure Separator

importTextParser :: Parser Text
importTextParser = takeTill isEndOfLine
