class Altoviz < Formula
  desc "Command-line interface for the Altoviz invoicing app"
  homepage "https://developer.altoviz.com"
  version "0.0.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-arm64.tar.gz"
      sha256 "9e5ef92adea68ac0fa1252da4a27786ceac578e55a967792a35a2db811844c71"
    else
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-x64.tar.gz"
      sha256 "e531fd57dcf7e19ffe539e892c6eeb2e2f76f16eec4825caadc044706e2a9708"
    end
  end

  on_linux do
    url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-linux-x64.tar.gz"
    sha256 "3d8250a88788ca6743096642dadc52cc5bf143179c484128f26b606c58e0a137"
  end

  def install
    bin.install "altoviz"
    bash_completion.install "completions/altoviz.bash" => "altoviz"
    zsh_completion.install "completions/altoviz.zsh" => "_altoviz"
    fish_completion.install "completions/altoviz.fish"
  end

  def caveats
    <<~EOS
      To get started, configure your API key:
        altoviz configure
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/altoviz version")
    assert_match "altoviz", shell_output("#{bin}/altoviz about")
  end
end
