class Altoviz < Formula
  desc "Command-line interface for the Altoviz invoicing app"
  homepage "https://developer.altoviz.com"
  version "0.0.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-arm64.tar.gz"
      sha256 "13216802bedb3ed0862855d69fd37bd438acc146e91403d69eacfcc1fb476f63"
    else
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-x64.tar.gz"
      sha256 "486f5a8034f59dc41f35ee33652cbc7cb4c1484b600b76db148b5fcadf3895fb"
    end
  end

  on_linux do
    url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-linux-x64.tar.gz"
    sha256 "661896df79766cc5376fab0c7954312a12927deaa25f413cc8f25d54c504e0eb"
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
