//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-13  Jed Young  Creation
//

**
** Image represents a graphical image.
**
@Js
mixin Image
{
  abstract Size size()
}

**
** Immutable Image
**
@Js
const mixin ConstImage : Image
{
  **
  ** make form uri
  **
  static new make(Uri uri) { GfxEnv.cur.makeConstImage(uri) }

  **
  ** is loaded ready for javascript
  **
  abstract Bool isReady()
}

**
** Buffered Image
**
@Js
mixin BufImage : Image
{
  //abstract Size size()

  **
  ** Returns the pixel value at x,y
  **
  abstract Int getPixel(Int x, Int y)

  **
  ** Set the pixel value at x,y
  **
  abstract Void setPixel(Int x, Int y, Int value)

  **
  ** to Const Image
  **
  abstract ConstImage toConst()

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
  static new fromUri(Uri uri, |This| onLoad) { GfxEnv.cur.fromUri(uri, onLoad) }

  **
  ** make form input stream
  **
  static Image fromStream(InStream in) { GfxEnv.cur.fromStream(in) }

  **
  ** make an empty image
  **
  static new make(Size size) { GfxEnv.cur.makeImage(size); }

  **
  ** get graphics context from image
  **
  abstract Graphics graphics()

  **
  ** Free any operating system resources used by this instance.
  **
  abstract Void dispose()
}