class Wavelet < Formula
  desc "Homoiconic language for the WebAssembly Component Model"
  homepage "https://github.com/logaan/wavelet"
  url "https://github.com/logaan/wavelet/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "d1167507851b97df0fc733ea8472e22b78433f86bd5faa1e4792be9fed5d7153"
  license "MIT"
  head "https://github.com/logaan/wavelet.git", branch: "main"

  depends_on "rust" => :build

  def install
    # The compiler CLI (`wavelet`) lives in the root crate; the language server
    # (`wavelet-lsp`) is a separate workspace under tooling/ that path-depends on
    # it. Install both binaries into the same prefix.
    system "cargo", "install", *std_cargo_args(path: ".")
    system "cargo", "install", *std_cargo_args(path: "tooling/wavelet-lsp")
  end

  test do
    assert_match "wavelet #{version}", shell_output("#{bin}/wavelet --version")
    assert_match "wavelet-lsp #{version}", shell_output("#{bin}/wavelet-lsp --version")

    # The compiler reads and prints the canonical WAVE form tree.
    (testpath/"hello.wvl").write "42\n"
    assert_match "42", shell_output("#{bin}/wavelet read #{testpath}/hello.wvl")
  end
end
