class Zint < Formula
  desc "Barcode encoding library supporting over 50 symbologies"
  homepage "https://sourceforge.net/projects/zint/"
  revision 3

  head "https://git.code.sf.net/p/zint/code.git"

  stable do
    url "https://kent.dl.sourceforge.net/project/zint/zint/2.6.1/zint-2.6.1.tar.gz"
    sha256 "f50aa7fbe667f76f31d2ae4170d481692f1dcdda62e42b2130cec7522330d2b2"
    # Just wrap malloc.h and ignore it. This is already fixed in HEAD but no
    # the latest release 2.6.1
    patch :p1, :DATA
  end

  bottle do
    cellar :any
    sha256 "9b8f1d855612eda58bda591f1acff56d0ece37271089476724bedf8b8815abf3" => :high_sierra
    sha256 "4c97ab4ebc7659744ba54c3a37402a3baec7c9726d42b7976b6cb07b08a7ef9f" => :sierra
    sha256 "0d17d6cc0d330cb09dac162a8a56b69f97195761d26414b9898742af3ff35d9f" => :el_capitan
    sha256 "8f7447588b730925be6f5e4d366a03394046933b1ae9ce6aebbcd102c8898d77" => :yosemite
    sha256 "bfbd68636ae952c6b4bb27ac6eadfca425ea5658be708c1152baa0d336d6fce8" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "libpng"

  def install
    # Sandbox fix: install FindZint.cmake in zint's prefix, not cmake's.
    inreplace "CMakeLists.txt", "${CMAKE_ROOT}", "#{share}/cmake"

    mkdir "zint-build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/zint", "-o", "test-zing.png", "-d", "This Text"
  end
end

__END__

diff --git a/backend/emf.c b/backend/emf.c
index 31199d5..bafd598 100644
--- a/backend/emf.c
+++ b/backend/emf.c
@@ -35,7 +35,9 @@
 #include <stdio.h>
 #include <string.h>
 #include <math.h>
+#ifdef _MSC_VER
 #include <malloc.h>
+#endif
 #include "common.h"
 #include "emf.h"

