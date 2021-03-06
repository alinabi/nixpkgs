{ stdenv, fetchurl, pkgconfig, glib, babl, libpng, cairo, libjpeg, which
, librsvg, pango, gtk, bzip2, json_glib, intltool, autoreconfHook, libraw }:

stdenv.mkDerivation rec {
  name = "gegl-0.3.18";

  src = fetchurl {
    url = "http://download.gimp.org/pub/gegl/0.3/${name}.tar.bz2";
    sha256 = "1ywihjav9yhmsvbrdyx9c5q71rqdkjg8l66ywca6s4yydvr8x1fp";
  };

  hardeningDisable = [ "format" ];

  # needs fonts otherwise  don't know how to pass them
  configureFlags = "--disable-docs";

  buildInputs = [
    babl libpng cairo libjpeg librsvg pango gtk bzip2 which json_glib intltool
    libraw
  ];

  nativeBuildInputs = [ pkgconfig autoreconfHook ];

  meta = {
    description = "Graph-based image processing framework";
    homepage = http://www.gegl.org;
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.linux;
  };
}
