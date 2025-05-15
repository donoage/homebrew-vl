class Vl < Formula
  desc "Command-line tool to display stock volume leaders (cross-platform)"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.11/bin/vl"
  sha256 "6a65cf0793e1db350a1244272f0147a1696854f9db6f6ebbc12d73347e2f0908"
  version "3.0.11"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 