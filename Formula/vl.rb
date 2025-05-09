class Vl < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v1.0.3/bin/vl"
  sha256 "88db58dc134997dc998d11dc2f123313562e688f942bd693291fa920c19a0267"
  version "1.0.4"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 