//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-11  Jed Young  Creation
//

using gfx

mixin Image2
{
  abstract Size size()
}

mixin Pixmap : Image2
{
  abstract Color getPixel(Int x, Int y)
  abstract Void setPixel(Int x, Int y, Color value)

  abstract Image toImage()

  abstract Void save(OutStream out, MimeType format := MimeType.forExt("png"))
  static Pixmap load(InStream in) { GfxEnv2.cur.load(in); }

  static Pixmap fromUri(Uri uri) { GfxEnv2.cur.fromUri(uri); }
  static Pixmap make(Size size) { GfxEnv2.cur.makePixmap(size); }

  abstract Graphics2 graphics()
}