class Webkitgtk < Formula
  desc "Webkit port for gtk"
  homepage "https://webkitgtk.org/"
#  url "https://webkitgtk.org/releases/webkitgtk-2.31.91.tar.xz"
#  sha256 "29a60b28dfbff1e25e53f63549cf6b68b7af97c7336947e705a32f234cad834c"
  url "https://webkitgtk.org/releases/webkitgtk-2.30.6.tar.xz"
  sha256 "50736ec7a91770b5939d715196e5fe7209b93efcdeef425b24dc51fb8e9d7c1e"
  license "LGPLv2+"

  depends_on "gtk+3"
  depends_on "libsecret"
  depends_on "enchant"
  depends_on "libnotify"
  depends_on "woff2"
  depends_on "icu4c"
  depends_on "gettext"
  depends_on "cmake" => :build
  depends_on "ninja" => :build

  patch :DATA
  
  def install
    opts = %W[
         -GNinja
         -DCMAKE_C_FLAGS_RELEASE="-O3 -DNDEBUG"
         -DCMAKE_CXX_FLAGS_RELEASE="-O3 -DNDEBUG"
         -DPORT=GTK
         -DENABLE_GRAPHICS_CONTEXT_GL=OFF
         -DUSE_LIBHYPHEN=OFF
         -DUSE_SYSTEMD=OFF
         -DENABLE_GAMEPAD=OFF
         -DICU_ROOT=#{Formula["icu4c"].opt_prefix}
    ]

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, *opts
      system "cmake", "--build", "."
      system "cmake", "--build", ".", "--", "install"
    end
        # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  test do
    system "false"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 0478d0c..756a06a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -8,10 +8,12 @@
 # and loading the cross-compilation settings from CMAKE_TOOLCHAIN_FILE.
 #
 
-cmake_minimum_required(VERSION 3.10)
+cmake_minimum_required(VERSION 3.20)
 
 project(WebKit)
 
+find_package(ICU COMPONENTS data uc i18n REQUIRED)
+
 if (NOT CMAKE_BUILD_TYPE)
     message(WARNING "No CMAKE_BUILD_TYPE value specified, defaulting to RelWithDebInfo.")
     set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "Choose the type of build." FORCE)
