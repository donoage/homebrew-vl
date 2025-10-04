class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/5a24b5acd7449ac2dc54bf9da580dd7f89a7b03f/bin/vl"
  sha256 "9f1f4791575ff359b59e8653bc0265af74999d7954ec55d8d9fd5d28e5627596"
  version "3.0.43"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 