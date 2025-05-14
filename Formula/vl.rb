class Vl < Formula
  desc "Command-line tool to display stock volume leaders (cross-platform)"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v2.3.0/bin/vl"
  sha256 "1edf42f8ae970bac2bd6537c6bc26f56c8ad4542e46462f3526ecbd1e1df0022"
  version "2.3.0"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 