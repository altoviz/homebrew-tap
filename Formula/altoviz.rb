class Altoviz < Formula
  desc "Command-line interface for the Altoviz invoicing app"
  homepage "https://developer.altoviz.com"
  version "0.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-arm64.tar.gz"
      sha256 "6ab016bd045114995db3625dc72304dd76cb6cdb12daa218de62d0a0e1d689a3"
    else
      url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-osx-x64.tar.gz"
      sha256 "5e013cddaba9f39316b1c36ded699d27663b07c528d7c87453c6f23e510cbf0f"
    end
  end

  on_linux do
    url "https://github.com/altoviz/cli/releases/download/v#{version}/altoviz-linux-x64.tar.gz"
    sha256 "a68dd15b04a71069c07f0ff6d3eb23d6aee68eab28a041c4a273697ebffd9bde"
  end

  def install
    bin.install "altoviz"

    # Install shell completions
    generate_completions_from_executable(bin/"altoviz", "completion")
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
