//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-9-9  Jed Young  Creation
//

using vaseGraphics

**
** Image represents a graphical image.
**
rtconst class NImage : Image
{
  private Int handle
  private Int flags
  private Int data
  Int width { private set }
  Int height { private set }

  protected new privateMake() : super.privateMake() {}

  new makeData(Int data, Int w, Int h) {
    this.data = data
    width = w
    height = h
  }

  override Size size() { Size(width, height) }

  **
  ** is loaded in javascript
  **
  override Bool isReady() { data != 0 }

  **
  ** Returns the pixel value at x,y
  **
  native override Int getPixel(Int x, Int y)

  **
  ** Set the pixel value at x,y
  **
  native override Void setPixel(Int x, Int y, Int p)

  **
  ** Save image to outStream.
  **
  native override Void save(OutStream out, Str format := "png")


  protected native override Graphics createGraphics()

  **
  ** Free any operating system resources used by this instance.
  **
  override native Void dispose()

  internal Void swap(NImage other) {
    d := this.data
    w := this.width
    h := this.height
    hd := this.handle
    this.data = other.data
    this.width = other.width
    this.height = other.height
    this.handle = other.handle
    other.data = d
    other.width = w
    other.height = h
    other.handle = hd
  }

  protected native override Void finalize()
}
