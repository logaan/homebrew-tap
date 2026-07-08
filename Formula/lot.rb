class Lot < Formula
  desc "Manage git-backed lists of anything from the command-line"
  homepage "https://github.com/logaan/lot.rs"
  version "0.1.0"
  license "MIT"

  # Build the latest from main (requires a Rust toolchain) with `--HEAD`.
  head do
    url "https://github.com/logaan/lot.rs.git", branch: "main"
    depends_on "rust" => :build
  end

  # Prebuilt binaries from the GitHub Release -- no Rust toolchain is pulled in.
  # Bump `version` and the four url/sha256 pairs to point at a newer release.
  on_macos do
    on_arm do
      url "https://github.com/logaan/lot.rs/releases/download/v0.1.0/lot-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "affe5112518ae4342f5cd3d40c3780ba5b55f0cc1459c263ed6a910ee4216ca1"
    end
    on_intel do
      url "https://github.com/logaan/lot.rs/releases/download/v0.1.0/lot-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "b3d9d175e2dabe8e9b01011533d0fda7694326a416bf551c2251af1bea2da656"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/logaan/lot.rs/releases/download/v0.1.0/lot-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c2499cd91499870b615c3d258a2e8afb389fc8b225353221d1970ef6f6d708cd"
    end
    on_intel do
      url "https://github.com/logaan/lot.rs/releases/download/v0.1.0/lot-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0b06ef99e6b4db7a2b093ab09bc55312ae43a77dc6c3d34472530aa436b8e5d3"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "crates/lot-cli")
    else
      bin.install "lot"
    end
  end

  test do
    assert_match(/^lot \d+\.\d+\.\d+/, shell_output("#{bin}/lot --version"))

    ENV["GIT_AUTHOR_NAME"] = ENV["GIT_COMMITTER_NAME"] = "brew test"
    ENV["GIT_AUTHOR_EMAIL"] = ENV["GIT_COMMITTER_EMAIL"] = "test@brew.sh"
    system bin/"lot", "vault", "new", testpath/"vault"
    assert_path_exists testpath/"vault/readme.md"
  end
end
