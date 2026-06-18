class Altoviz < Formula
  desc "Command-line interface for the Altoviz invoicing app"
  homepage "https://developer.altoviz.com"
  version "0.0.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-arm64.tar.gz"
      sha256 "3d86727c0a06569cea73ac2e7d1d6c0ec69d6ca6f5735e49da48a438bd5e47a9"
    else
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-x64.tar.gz"
      sha256 "5e0e4bf9316463e8f706fb9b769d21a594c7ff3a7b9fd403fd152ab993a4fa98"
    end
  end

  on_linux do
    url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-linux-x64.tar.gz"
    sha256 "0d6e88e7ffacd8fa542dd4fed6aa88fa129c192214ff4292a6ba4c1008ed482f"
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
