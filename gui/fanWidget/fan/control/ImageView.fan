//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanWt
using fan2d

class ImageView : Widget
{
  ConstImage image

  new make(|This| f)
  {
    style = ImageStyle()
    f(this)
  }
}