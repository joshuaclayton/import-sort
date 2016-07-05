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

        it "returns the original string if parsing failed" $ do
            let string = "import qualified Data.List as L\nfoo\n"

            S.sortImport string `shouldBe` string
