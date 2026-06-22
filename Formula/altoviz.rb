class Altoviz < Formula
  desc "Command-line interface for the Altoviz invoicing app"
  homepage "https://developer.altoviz.com"
  version "0.0.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-arm64.tar.gz"
      sha256 "6f706b2aeed6aeb3cb548c7f2667f56534ec0037e1ff6aae66646f52b790ad61"
    else
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-x64.tar.gz"
      sha256 "cee6acb4513af44d17ec74ea29231da670399594c042875e0f570eda9e9884f0"
    end
  end

  on_linux do
    url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-linux-x64.tar.gz"
    sha256 "8708684598e0a468132e0919d00ae2e77c1bf40d3ec0abf6c5e7bcfc259411ec"
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
        altoviz config create
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/altoviz version")
    assert_match "altoviz", shell_output("#{bin}/altoviz about")
  end
end
