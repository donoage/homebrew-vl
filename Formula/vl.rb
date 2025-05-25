class Vl < Formula
  desc "Command-line tool to display stock volume leaders without closing extra browser windows"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.22/bin/vl"
  sha256 "3eacdba60726c7f2214f5e671e984e0cce7fa248152166edaa745d544dddc891"
  version "3.0.22"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 