//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** A display area for image
**
@Js
class ImageView : Widget
{
  ConstImage image

  new make(|This| f)
  {
    f(this)
  }
}