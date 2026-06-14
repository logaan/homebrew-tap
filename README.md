# logaan/homebrew-tap

A personal [Homebrew](https://brew.sh) tap — a small collection of formulae for
my own tools and anything I want installable with `brew` without going through
homebrew-core.

## Usage

Install a formula directly:

```console
brew install logaan/tap/<formula>
```

Or tap once, then install by bare name:

```console
brew tap logaan/tap
brew install <formula>
```

(`logaan/tap` is shorthand for this repo, `github.com/logaan/homebrew-tap` — the
`homebrew-` prefix is required by Homebrew and dropped in the short name.)

## Formulae

| Formula | Description | Installs |
| --- | --- | --- |
| [`wavelet`](Formula/wavelet.rb) | Homoiconic language for the WebAssembly Component Model | `wavelet` (compiler/CLI) and `wavelet-lsp` (language server) |

Build the bleeding edge from `main` instead of the latest release with
`--HEAD`, e.g. `brew install --HEAD logaan/tap/wavelet`.

## Adding a formula

Drop a `Formula/<name>.rb` into this repo and push.
[`Formula/wavelet.rb`](Formula/wavelet.rb) is a worked example of the
**prebuilt-binary** pattern: per-platform `url` + `sha256` under
`on_macos`/`on_linux` and `on_arm`/`on_intel`, with no `depends_on` so
installing pulls no build toolchain (and a `head` block that builds from source
for `--HEAD`).

For a project that only ships source, the **build-from-source** pattern is
smaller — a single `url` to a release tarball, `depends_on "rust" => :build` (or
whatever toolchain), and a `cargo install`/`make` in `install`. See the Homebrew
[Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) for templates.

Lint before pushing:

```console
brew style logaan/tap
brew audit --tap logaan/tap --strict --online <name>
```
