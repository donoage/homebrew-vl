class Vl < Formula
  desc "Command-line tool to display stock volume leaders (cross-platform)"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.6/bin/vl"
  sha256 "dbf60c0a8aac1f8c2e612aefbf71f5cf829b5e5d23d8b384ebdfdf590abfe306"
  version "3.0.6"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 