class Wavelet < Formula
  desc "Homoiconic language for the WebAssembly Component Model"
  homepage "https://github.com/logaan/wavelet"
  license "MIT"

  # Build the latest from main (requires a Rust toolchain) with `--HEAD`.
  head do
    url "https://github.com/logaan/wavelet.git", branch: "main"
    depends_on "rust" => :build
  end

  # Prebuilt binaries — no Rust toolchain is pulled in. Each tarball bundles the
  # CLI (wavelet) and the language server (wavelet-lsp) for one platform.
  on_macos do
    on_arm do
      url "https://github.com/logaan/wavelet/releases/download/v0.2.5/wavelet-aarch64-apple-darwin.tar.gz"
      sha256 "214684a009ab4b5e74758032c39812275f5d4dc4a06174c734f32a32a9412fdb"
    end
    on_intel do
      url "https://github.com/logaan/wavelet/releases/download/v0.2.5/wavelet-x86_64-apple-darwin.tar.gz"
      sha256 "331677390e833cb284e31d77a7f73e701cbe445fa9938c3eaddf120f7311c5c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/logaan/wavelet/releases/download/v0.2.5/wavelet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e58a12865a7bdad3b154fc5d72b4ad7e02e7034ed906d61d2acb2c2609b80ce6"
    end
    on_intel do
      url "https://github.com/logaan/wavelet/releases/download/v0.2.5/wavelet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bff251a266621cb2d03725ea563b9e2c02c73e267045c1bd872ddfbaffb1cccd"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: ".")
      system "cargo", "install", *std_cargo_args(path: "tooling/wavelet-lsp")
    else
      bin.install "wavelet", "wavelet-lsp"
    end
  end

  test do
    assert_match(/^wavelet \d+\.\d+\.\d+/, shell_output("#{bin}/wavelet --version"))
    assert_match(/^wavelet-lsp \d+\.\d+\.\d+/, shell_output("#{bin}/wavelet-lsp --version"))

    (testpath/"hello.wvl").write "42\n"
    assert_match "42", shell_output("#{bin}/wavelet read #{testpath}/hello.wvl")
  end
end
