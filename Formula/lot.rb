class Lot < Formula
  desc "Manage git-backed lists of anything from the command-line"
  homepage "https://github.com/logaan/lot.rs"
  # No tagged releases yet, so build from a pinned commit on main. Bump the
  # revision (and version, when the crate version changes) to update.
  url "https://github.com/logaan/lot.rs.git",
      revision: "6de1fb6056425482c2b2f9412b0440296df86580"
  version "0.1.0"
  license "MIT"
  # Build the latest from main instead of the pinned revision with `--HEAD`.
  head "https://github.com/logaan/lot.rs.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/lot-cli")
  end

  test do
    assert_match(/^lot \d+\.\d+\.\d+/, shell_output("#{bin}/lot --version"))

    ENV["GIT_AUTHOR_NAME"] = ENV["GIT_COMMITTER_NAME"] = "brew test"
    ENV["GIT_AUTHOR_EMAIL"] = ENV["GIT_COMMITTER_EMAIL"] = "test@brew.sh"
    system bin/"lot", "vault", "new", testpath/"vault"
    assert_path_exists testpath/"vault/readme.md"
  end
end
