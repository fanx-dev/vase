//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-11  Jed Young  Creation
//

using gfx
using fan3dMath

mixin Graphics2 : Graphics
{
  abstract This drawImage2(Image2 image, Int x, Int y)
  abstract This copyImage2(Image2 image, Rect src, Rect dest)

  abstract Transform2D transform
}