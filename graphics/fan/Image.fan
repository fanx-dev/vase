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
rtconst abstract class Image
{
  private Bool _immutable := false
  override Bool isImmutable() {
    return _immutable
  }

  override Obj toImmutable() {
    _immutable = false
    return this
  }

  abstract Size size()

  **
  ** is loaded in javascript
  **
  abstract Bool isReady()

  **
  ** Returns the pixel value at x,y
  **
  abstract Int getPixel(Int x, Int y)

  **
  ** Set the pixel value at x,y
  **
  abstract Void setPixel(Int x, Int y, Int value)

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
  abstract Void save(OutStream out, Str format := "png")

  **
  ** make form uri
  **
  static Image fromUri(Uri uri, |This|? onLoad := null) { GfxEnv.cur.fromUri(uri, onLoad) }

  **
  ** make form input stream
  **
  static Image fromStream(InStream in) { GfxEnv.cur.fromStream(in) }

  **
  ** make an empty image
  **
  static Image make(Size size) { GfxEnv.cur.makeImage(size); }

  protected new privateMake() {}

  **
  ** create graphics context from image and paint by the given function.
  **
  This paint(|Graphics| f) {
    g := graphics
    try {
      f(g)
    }
    finally {
      g.dispose
    }
    return this
  }

  **
  ** get graphics context from image
  **
  @NoDoc Graphics graphics() {
    if (_immutable) throw ReadonlyErr()
    return createGraphics
  }

  protected abstract Graphics createGraphics()

  **
  ** Free any operating system resources used by this instance.
  **
  abstract Void dispose()

  @NoDoc
  Void _swapImage(Image newImg) { GfxEnv.cur._swapImage(this, newImg) }
}