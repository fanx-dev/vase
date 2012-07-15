//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-13  Jed Young  Creation
//

using gfx

**
** Image data
**
@Js
mixin Image2
{
  abstract Size size()

  **
  ** Returns the pixel value at x,y
  **
  abstract Color getPixel(Int x, Int y)

  **
  ** Set the pixel value at x,y
  **
  abstract Void setPixel(Int x, Int y, Color value)

  **
  ** to Fwt Image
  **
  abstract Image toImage()

  **
  ** Save image to outStream. default format is png.
  ** Currently supported image formats are:
  ** - BMP (Windows or OS/2 Bitmap)
  ** - ICO (Windows Icon)
  ** - JPEG
  ** - GIF
  ** - PNG
  ** - TIFF
  **
  abstract Void save(OutStream out, MimeType format := MimeType.forExt("png"))

  **
  ** is loaded
  **
  abstract Bool isLoaded()

  **
  ** make form uri
  **
  static Image2 fromUri(Uri uri, |This| onLoad) { GfxEnv2.cur.fromUri(uri, onLoad) }

  static Image2 fromStream(InStream in) { GfxEnv2.cur.fromStream(in) }

  **
  ** make an empty image
  **
  static new make(Size size) { GfxEnv2.cur.makeImage2(size); }

  **
  ** get graphics context from image
  **
  abstract Graphics2 graphics()
}