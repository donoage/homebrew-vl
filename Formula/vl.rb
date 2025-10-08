class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/ac2b507074514ad3f06ab7be124a697f68290910/bin/vl"
  sha256 "2e7f32e01c9778da9825c72e3345217d9785ec24383b96ac57e4c47456d963c5"
  version "3.0.44"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 