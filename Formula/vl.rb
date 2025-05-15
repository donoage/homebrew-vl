class Vl < Formula
  desc "Command-line tool to display stock volume leaders (cross-platform)"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.14/bin/vl"
  sha256 "afe78cb54045c5269d40d2e8a59d58476045c4e4cdbef195206a0eb71e52c94c"
  version "3.0.14"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 