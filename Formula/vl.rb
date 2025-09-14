class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/a37b5184bdf74ce8aa4ec22b8e83f4b7f1f94f6d/bin/vl"
  sha256 "e961eab5fd555f9938b8443d5f47a1888252de742581cb339bfd1000942656ac"
  version "3.0.39"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 