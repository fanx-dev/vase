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
  private Bool isLoaded := true
  override Int width { private set }
  override Int height { private set }

  protected new privateMake() : super.privateMake() { isLoaded = false }

  new makeData(Int data, Int w, Int h) {
    this.data = data
    width = w
    height = h
  }

  **
  ** is loaded in javascript
  **
  override Bool isReady() { isLoaded }

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
    ld := this.isLoaded
    this.data = other.data
    this.width = other.width
    this.height = other.height
    this.handle = other.handle
    this.isLoaded = other.isLoaded
    other.data = d
    other.width = w
    other.height = h
    other.handle = hd
    other.isLoaded = ld
  }

  //protected native override Void finalize()
}
