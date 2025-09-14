class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/5ce11844ec8b2bcd7e64df6c7eb27bb76d8251d5/bin/vl"
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