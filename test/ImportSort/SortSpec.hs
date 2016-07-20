module ImportSort.SortSpec where

import           Test.Hspec
import qualified ImportSort.Sort as S

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

        it "returns the original string if parsing failed" $ do
            let string = "import qualified Data.List as L\nfoo\n"

            S.sortImport string `shouldBe` string
