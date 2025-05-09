class Volumeleaders < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  bottle do
    root_url "https://github.com/donoage/homebrew-vl/releases/download/volumeleaders"
    sha256 cellar: :any_skip_relocation, monterey: "eeaa646cc346ccc5209960d2f950333f443b13cbe6629cdd62b99c6c35c52f1c"
  end

  def install
    bin.install "volumeleaders"
  end

  test do
    system "#{bin}/volumeleaders", "--help"
  end
end 