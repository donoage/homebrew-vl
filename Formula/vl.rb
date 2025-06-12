class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/b67bf95620f8ed093da1a02064450c04760bcadd/bin/vl"
  sha256 "e96fdfeb6272e2a91fbcc14e0febad625a135ff13863a23f8dc1f13a397885ec"
  version "3.0.35"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 