class Pdfpc < Formula
  desc "Presenter console with multi-monitor support for PDF files"
  homepage "https://pdfpc.github.io/"
  url "https://github.com/pdfpc/pdfpc/archive/v4.4.1.tar.gz"
  sha256 "4adb42fd1844a7e2ab44709dd043ade618c87f2aaec03db64f7ed659e8d3ddad"
  license "GPL-3.0-or-later"
  head "https://github.com/pdfpc/pdfpc.git"

  bottle do
    sha256 big_sur:  "b2de1a251cd401445b171247210e1e3a729cd793eeddfe7e725039b4ea9d272c"
    sha256 catalina: "6797e6bfdcff10e4e4b099d28547f608fbbc4aa94c0063d04b0e4d5195924f63"
    sha256 mojave:   "ceb38afd15133764d031c8abca4aabbd39fb2407bac81e0b0c0d8b9511e249cf"
  end

  depends_on "cmake" => :build
  depends_on "vala" => :build
  depends_on "ninja" => :build
  depends_on "gst-plugins-good"
  depends_on "gtk+3"
  depends_on "libgee"
  depends_on "librsvg"
  depends_on "poppler"
#  depends_on "webkit-gtk"

  def install
    opts = %W[
         -GNinja
         -DCMAKE_BUILD_TYPE=Release
         -DMOVIES=on
    ]
    system "cmake", ".", *std_cmake_args, *opts
    system "cmake", "--build", "."
    system "cmake", "--build", "--", "install"
  end

  test do
    system "#{bin}/pdfpc", "--version"
  end
end
