//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-9-9  Jed Young  Creation
//

using vaseGraphics

const class NFont : Font {
  const Int handle

  new privateMake(|This| f) : super.privateMake(f) {
  }

  **
  ** Free any operating system resources used by this font.
  ** Dispose is required if this color has been used in an operation
  ** such as FWT onPaint which allocated a system resource to
  ** represent this instance.
  **
  native override Void dispose()

  **
  ** Get height of this font which is the pixels is the sum of
  ** ascent, descent, and leading.
  **
  override Int height() { ascent + descent + leading }

  **
  ** Get ascent of this font which is the distance in pixels from
  ** baseline to top of chars, not including any leading area.
  **
  native override Int ascent()

  **
  ** Get descent of this font which is the distance in pixels from
  ** baseline to bottom of chars, not including any leading area.
  **
  native override Int descent()

  **
  ** Get leading of this font which is the distance in pixels above
  ** the ascent which may include accents and other marks.
  **
  native override Int leading()

  **
  ** Get the width of the string in pixels when painted
  ** with this font.
  **
  native override Int width(Str s)

  native protected override Void finalize()
}
