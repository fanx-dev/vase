//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

**
** A display area for a short text string.
**
@Js
mixin TextView
{
  abstract Str text
  abstract Font font

  protected virtual Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    w := font.width(text)
    h := font.height
    return result.set(w, h)
  }
}