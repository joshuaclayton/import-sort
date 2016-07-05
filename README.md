# ImportSort

ImportSort is a utility to format and sort Haskell imports alphabetically.

![Image of ImportSort Usage](http://i.giphy.com/3o6Zt81lkoEzgBBK9O.gif)

## Installation

Clone this repository, then run:

```sh
stack setup
stack install
```

## Usage

The intended use-case is Vim, but if your editor supports executing a binary
against visually-selected text this should still work.

Create a visual selection across whatever imports you want to sort (`Shift-v`,
plus any navigation), `:` (to run a command), then type `!import-sort` and hit
return. This will run `import-sort` against highlighted imports.

## License

Copyright 2016 Josh Clayton. See the [LICENSE](LICENSE).
