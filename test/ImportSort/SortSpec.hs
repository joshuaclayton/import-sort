module ImportSort.SortSpec where

import qualified ImportSort.Sort as S
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = parallel $
    describe "sort" $ do
        it "sorts values correctly" $ do
            let string = "import qualified Data.List as L\n\
                         \import System.IO\n\
                         \import           Data.List ((++))\n\
                         \import Data.Char (isAlpha)\n\
                         \import qualified Data.Map.Strict as Map\n"

            S.sortImport string `shouldBe`
                         "import           Data.Char (isAlpha)\n\
                         \import           Data.List ((++))\n\
                         \import qualified Data.List as L\n\
                         \import qualified Data.Map.Strict as Map\n\
                         \import           System.IO"

        it "doesn't introduce a column for 'qualified' if none are present" $ do
            let string = "import Data.List ((++))\n\
                         \import           Data.Bifunctor (first)\n"

            S.sortImport string `shouldBe`
                        "import Data.Bifunctor (first)\n\
                        \import Data.List ((++))"

        it "retains newlines as separators" $ do
            let string = "import Data.Maybe (catMaybes)\n\
                         \import Data.List ((++))\n\n\
                         \import qualified Data.Bifunctor as BF\n"

            S.sortImport string `shouldBe`
                        "import           Data.List ((++))\n\
                        \import           Data.Maybe (catMaybes)\n\n\
                        \import qualified Data.Bifunctor as BF"

        it "allows for full file context" $ do
            let string = "module Awesome where\n\n\
                         \import Data.Maybe (catMaybes)\n\
                         \import Data.List ((++))\n\n\
                         \import qualified Data.Bifunctor as BF\n\n\
                         \link :: Int\n\
                         \link = 1\n\n\
                         \importPrefixedFunction :: Int\n\
                         \importPrefixedFunction = 2\n"

            S.sortImport string `shouldBe`
                        "module Awesome where\n\n\
                        \import           Data.List ((++))\n\
                        \import           Data.Maybe (catMaybes)\n\n\
                        \import qualified Data.Bifunctor as BF\n\n\
                        \link :: Int\n\
                        \link = 1\n\n\
                        \importPrefixedFunction :: Int\n\
                        \importPrefixedFunction = 2"

        it "returns the original string if parsing failed" $ do
            let string = "import qualified Data.List as L\nfoo"

            S.sortImport string `shouldBe` string
