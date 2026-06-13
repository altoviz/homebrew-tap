class Altoviz < Formula
  desc "Command-line interface for the Altoviz invoicing app"
  homepage "https://developer.altoviz.com"
  version "0.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-arm64.tar.gz"
      sha256 "4beca165999bfb2f921376c101b183ca0cfce4f46a6b89b043a98ca54c50ade2"
    else
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-x64.tar.gz"
      sha256 "29e81e1d151bb4a3cc6780d1a3b8e65bd535723fd7189308c0cad51b1f798e91"
    end
  end

  on_linux do
    url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-linux-x64.tar.gz"
    sha256 "7068f6bd458af8dc9154d5ea4394cfa5d37f4bee6295af08c8543931c973d3f1"
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
