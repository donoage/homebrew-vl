class Volumeleaders < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://github.com/donoage/homebrew-vl/releases/download/volumeleaders/volumeleaders"
  sha256 "bb7026a769375a5110b11f1634ab8d18761bc8ab7b81c27c7d52cc8a4d19d6fd"
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