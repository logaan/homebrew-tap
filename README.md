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

Drop a `Formula/<name>.rb` into this repo and push. For a Rust project that
publishes tagged releases, the build-from-source pattern is:

```ruby
class Foo < Formula
  desc "..."
  homepage "https://github.com/logaan/foo"
  url "https://github.com/logaan/foo/archive/refs/tags/v1.2.3.tar.gz"
  sha256 "..." # shasum -a 256 of the tarball above
  license "MIT"
  head "https://github.com/logaan/foo.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "foo #{version}", shell_output("#{bin}/foo --version")
  end
end
```

Lint before pushing:

```console
brew style logaan/tap
brew audit --tap logaan/tap --strict --online
```
