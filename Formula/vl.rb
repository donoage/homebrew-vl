class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/92e2666a497bc61570250ffd4eedbfca673bb9f5/bin/vl"
  sha256 "a70431f44a00607313887954d89382925be8ced8d2dbb33b4c3cdb65b55ab698"
  version "3.0.34"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 