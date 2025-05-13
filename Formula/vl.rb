class Vl < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v1.0.8/bin/vl"
  sha256 "21946108badbcc4cd2f92f997bccf0577c0c97163a6bfcf02df321845836bf36"
  version "1.0.8"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 