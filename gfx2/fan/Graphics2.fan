//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-11  Jed Young  Creation
//

using gfx
using fan3dMath
using array

mixin Graphics2 : Graphics
{
  abstract This drawImage2(Image2 image, Int x, Int y)
  abstract This copyImage2(Image2 image, Rect src, Rect dest)

  abstract This drawPath(Path path)
  abstract This fillPath(Path path)

  abstract This drawPolyline2(Array p)
  abstract This fillPolygon2(Array p)

  abstract Transform2D transform
}