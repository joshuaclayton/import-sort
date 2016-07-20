# ImportSort

ImportSort is a utility to format and sort Haskell imports alphabetically.

![Image of ImportSort Usage](http://i.giphy.com/3o6Zt81lkoEzgBBK9O.gif)

## Supported Behavior

ImportSort correctly handles one or many single-line imports.

It sorts and aligns imports correctly:

```haskell
-- | old
import qualified Data.List as L
import System.IO
import           Data.List ((++))
import Data.Char (isAlpha)
import qualified Data.Map.Strict as Map

-- | new
import           Data.Char (isAlpha)
import           Data.List ((++))
import qualified Data.List as L
import qualified Data.Map.Strict as Map
import           System.IO
```

If no qualified imports are present, it doesn't indent modules:

```haskell
-- | old
import           Data.List ((++))
import           Data.Maybe (catMaybes)

-- | new
import Data.List ((++))
import Data.Maybe (catMaybes)
```

If import-sort cannot parse the list of imports, the value is returned
unchanged:

```haskell
-- | old
import           Data.List ((++))
-- | TODO: do something
import           Data.Maybe (catMaybes)

-- | new
import           Data.List ((++))
-- | TODO: do something
import           Data.Maybe (catMaybes)
```

## Installation

### Homebrew (Recommended)

You can install [my formulae] via [Homebrew] with `brew tap`:

```sh
brew tap joshuaclayton/formulae
```

Next, run:

```sh
brew install import-sort
```

[my formulae]: https://github.com/joshuaclayton/homebrew-formulae
[Homebrew]: http://brew.sh/

To update, run:

```sh
brew update
brew upgrade import-sort
```

Alternatively, you can install by hand.

### Installing by hand

This project is written in [Haskell] and uses [Stack].

Once you have these tools installed and the project cloned locally:

```sh
stack setup
stack install
```

This will generate a binary in `$HOME/.local/bin`; ensure this directory is in
your `$PATH`.

[Haskell]: https://www.haskell.org
[Stack]: http://www.haskellstack.org

## Usage

The intended use-case is Vim, but if your editor supports executing a binary
against visually-selected text this should still work.

Create a visual selection across whatever imports you want to sort (`Shift-v`,
plus any navigation), `:` (to run a command), then type `!import-sort` and hit
return. This will run `import-sort` against highlighted imports.

## License

Copyright 2016 Josh Clayton. See the [LICENSE](LICENSE).
