//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-10  Jed Young  Creation
//

**
** AffineTransform.
** This matrix is a transpose of java.awt.geom.AffineTransform.
**
**                               m00 m10 0
**    (x1, y1, 1) = (x y 1)  *   m01 m11 0
**                               m02 m12 1
**
** But the awt/swt Transform like this:
**
**      [ x']   [  m00  m01  m02  ] [ x ]   [ m00x + m01y + m02 ]
**      [ y'] = [  m10  m11  m12  ] [ y ] = [ m10x + m11y + m12 ]
**      [ 1 ]   [   0    0    1   ] [ 1 ]   [         1         ]
**
** Don't like Transform2D, The Transform3D using the second way.
**
@Js
class Transform2D
{
  Matrix matrix := Matrix.makeIndentity(3)

  Float get(Int x, Int y) { return matrix.get(x, y); }
  Transform2D clone() { return Transform2D { it.matrix = this.matrix.clone } }

//////////////////////////////////////////////////////////////////////////
// Transform
//////////////////////////////////////////////////////////////////////////

  This translate(Float tx, Float ty)
  {
    matrix = matrix * makeTranslate(tx, ty)
    return this
  }

  This scale(Float x0, Float y0, Float sx, Float sy)
  {
    matrix = matrix * makeScale(x0, y0, sx, sy)
    return this
  }

  This symmetry(Float a, Float b, Float d, Float e)
  {
    matrix = matrix * makeSymmetry(a, b, d, e)
    return this
  }

  This rotate(Float x, Float y, Float thta)
  {
    matrix = matrix * makeRotate(x, y, thta)
    return this
  }

  This shear(Float b, Float d)
  {
    matrix = matrix * makeShear(b, d)
    return this
  }

  **
  ** transform the coordinate using current matrix.
  ** x: xy[0], y:[1]. The result will rewrite the list
  **
  Void transform(Float[] xy)
  {
    x := xy[0]
    y := xy[1]
    sour := Matrix.makeZero(1, 3)
    sour.set(0, 0, x)
    sour.set(0, 1, y)
    sour.set(0, 2, 1f)
    result := sour * matrix
    xy[0] = result.get(0, 0)
    xy[1] = result.get(0, 1)
  }

//////////////////////////////////////////////////////////////////////////
// Make Transform
//////////////////////////////////////////////////////////////////////////

  **
  ** translate
  **
  static Matrix makeTranslate(Float tx, Float ty)
  {
    at := Matrix.makeIndentity(3)
    at.set(0, 0, 1f)
    at.set(1, 1, 1f)
    at.set(2, 2, 1f)
    at.set(2, 0, tx)
    at.set(2, 1, ty)
    return at
  }

  **
  ** scale at x0,y0 point
  **
  static Matrix makeScale(Float x0, Float y0, Float sx, Float sy)
  {
    at := Matrix.makeIndentity(3)
    at.set(0, 0, sx)
    at.set(1, 1, sy)
    at.set(2, 2, 1f)
    at.set(2, 0, (1 - sx) * x0)
    at.set(2, 1, (1 - sy) * y0)
    return at
  }

  **
  ** symmetry is a mirror inversion
  **
  static Matrix makeSymmetry(Float a, Float b, Float d, Float e)
  {
    at := Matrix.makeIndentity(3)
    at.set(0, 0, a)
    at.set(1, 1, e)
    at.set(2, 2, 1f)
    at.set(0, 1, d)
    at.set(1, 0, b)
    return at
  }

  **
  ** roate at x,y with thta radians
  **
  static Matrix makeRotate(Float x, Float y, Float thta)
  {
    at := Matrix.makeIndentity(3)
    at.set(0, 0, (thta).cos)
    at.set(1, 1, (thta).cos)
    at.set(2, 2, 1f)
    at.set(0, 1, (thta).sin)
    at.set(1, 0, -(thta).sin)
    at.set(2, 0, (1 - (thta).cos) * x + (y * (thta).sin))
    at.set(2, 1, (1 - (thta).cos) * y - (x * (thta).sin))
    return at
  }

  **
  ** shear
  **
  static Matrix makeShear(Float b, Float d)
  {
    at := Matrix.makeIndentity(3)
    at.set(0, 0, 1f)
    at.set(1, 1, 1f)
    at.set(2, 2, 1f)
    at.set(0, 1, d)
    at.set(1, 0, b)
    return at
  }
}