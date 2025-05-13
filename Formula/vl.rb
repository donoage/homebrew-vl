class Vl < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v1.0.5/bin/vl"
  sha256 "32051ad2c953fbe5c33f33547109382342c7040f4f893f9f521d1daa9dcdb974"
  version "1.0.5"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 