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
    "import " *> skipSpace *> "qualified" *> skipSpace
    QualifiedImport <$> toEol

nonQualifiedImportParser :: Parser ModuleImport
nonQualifiedImportParser = do
    "import " *> skipSpace
    NonQualifiedImport <$> toEol

separatorParser :: Parser ModuleImport
separatorParser = Separator <$> toEol

toEol :: Parser Text
toEol = takeTill isEndOfLine <* endOfLine
