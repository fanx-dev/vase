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
@Js
rtconst class NImage : Image
{
  private Int handle
  private Array<Int8>? data
  Int width { private set }
  Int height { private set }

  protected new privateMake() : super.privateMake() {}

  new makeSize(Int w, Int h) {
    width = w
    height = h
    data = Array<Int8>(w*h*4)
  }

  override Size size() { Size(width, height) }

  **
  ** is loaded in javascript
  **
  override Bool isReady() { data != null }

  **
  ** Returns the pixel value at x,y
  **
  override Int getPixel(Int x, Int y) {
    pos := width * y + x
    a := data[pos].and(0xff)
    r := data[pos+1].and(0xff)
    g := data[pos+2].and(0xff)
    b := data[pos+3].and(0xff)
    return a.shiftl(24).or(r.shiftl(16)).or(g.shiftl(8)).or(b)
  }

  **
  ** Set the pixel value at x,y
  **
  override Void setPixel(Int x, Int y, Int p) {
    pos := width * y + x
    a := p.and(0xff000000).shiftr(24)
    r := p.and(0x00ff0000).shiftr(16)
    g := p.and(0x0000ff00).shiftr(8)
    b := p.and(0x000000ff)

    data[pos] = a
    data[pos+1] = r
    data[pos+2] = g
    data[pos+3] = b
  }

  **
  ** Save image to outStream.
  **
  native override Void save(OutStream out, Str format := "png")


  protected native override Graphics createGraphics()

  **
  ** Free any operating system resources used by this instance.
  **
  override Void dispose() {}

  internal Void swap(NImage other) {
    d := this.data
    w := this.width
    h := this.height
    this.data = other.data
    this.width = other.width
    this.height = other.height
    other.data = d
    other.width = w
    other.height = h
  }

  protected override Void finalize() { dispose }
}