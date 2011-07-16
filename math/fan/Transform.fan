//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-10  Jed Young  Creation
//

**
** model/view matrix and projection
**
@Js
class Transform
{
  private Matrix[] stack := [ Matrix.makeIndentity(4) ]

  Matrix top() { stack.peek }
  This set(Matrix m) { stack.set(stack.size - 1, m); return this }

  Matrix pop() { stack.pop }

  This push()
  {
    dup := top.clone
    stack.push(dup)
    return this
  }

//////////////////////////////////////////////////////////////////////////
// Transform
//////////////////////////////////////////////////////////////////////////

  This translate(Float x, Float y, Float z)
  {
    m := top * makeTranslate(x, y, z)
    set(m)
    return this
  }

  This scale(Float x, Float y, Float z)
  {
    m := top * makeScale(x, y, z)
    set(m)
    return this
  }

  This rotate(Float theta, Float x, Float y, Float z)
  {
    m := top * makeRotate(theta * Float.pi / 180f, x, y, z)
    set(m)
    return this
  }

//////////////////////////////////////////////////////////////////////////
// Make Transform
//////////////////////////////////////////////////////////////////////////

  static Matrix makeTranslate(Float x, Float y, Float z)
  {
    m := Matrix.makeIndentity(4)
    m.set(0, 3, x)
    m.set(1, 3, y)
    m.set(2, 3, z)
    return m
  }

  static Matrix makeScale(Float x, Float y, Float z)
  {
    m := Matrix.makeZero(4, 4)
    m.set(0, 0, x)
    m.set(1, 1, y)
    m.set(2, 2, z)
    m.set(3, 3, 1f)
    return m
  }

  static Matrix makeFrustum(Float left, Float right,
                            Float bottom, Float top,
                            Float znear, Float zfar)
  {
    X := 2 * znear / (right - left)
    Y := 2 * znear / (top - bottom)
    A := (right + left) / (right - left)
    B := (top + bottom) / (top - bottom)
    C := -(zfar + znear) / (zfar - znear)
    D := -2 * zfar * znear / (zfar - znear)

    return Matrix.make([
                         [X,  0f,  A,  0f],
                         [0f,  Y,  B,  0f],
                         [0f, 0f,  C,   D],
                         [0f, 0f, -1f, 0f],
                       ])
  }

  static Matrix makePerspective(Float fovy, Float aspect, Float znear, Float zfar)
  {
    ymax := znear * (fovy* Float.pi / 360f).tan
    ymin := -ymax
    xmin := ymin * aspect
    xmax := ymax * aspect

    return makeFrustum(xmin, xmax, ymin, ymax, znear, zfar)
  }

  static Matrix makeOrtho(Float left, Float right, Float bottom, Float top, Float znear, Float zfar)
  {
    tx := - (right + left) / (right - left)
    ty := - (top + bottom) / (top - bottom)
    tz := - (zfar + znear) / (zfar - znear)

    a := 2 / (right - left)
    b := 2 / (top - bottom)
    c := -2 / (zfar - znear)

    return Matrix.make([
                         [a,  0f, 0f, tx],
                         [0f,  b, 0f, ty],
                         [0f, 0f,  c, tz],
                         [0f, 0f, 0f, 1f ],
                       ])
  }

  static Matrix makeLookAt( Float ex, Float ey, Float ez,
                            Float cx, Float cy, Float cz,
                            Float ux, Float uy, Float uz)
  {
      eye := Vector(ex, ey, ez)
      center := Vector(cx, cy, cz)
      up := Vector(ux, uy, uz)

      z := eye.minus(center).normalize
      x := up.crossProduct(z).normalize
      y := z.crossProduct(x).normalize

      m := Matrix.make([[x.x, y.x, z.x, 0f],
                        [x.y, y.y, z.y, 0f],
                        [x.z, y.z, z.z, 0f],
                        [0f,   0f,  0f, 1f]])

      return m
  }

  static Matrix makeRotate(Float theta, Float x, Float y, Float z)
  {
     s := (theta).sin
     c := (theta).cos
     nc := 1 - c

     v := Vector(x, y, z)
     nv := v.normalize
     vx := nv.x
     vy := nv.y
     vz := nv.z

     m := Matrix.make([ [vx * vx * nc + c,      vx * vy * nc - vz * s,            vx * vz * nc + vy * s, 0f],
                        [vy * vx * nc + vz * s, vy * vy * nc + c, vy * vz * nc - vx * s,                 0f],
                        [vx * vz * nc - vy * s, vy * vz * nc + vx * s,            vz * vz * nc + c,      0f],
                        [0f,                    0f,                               0f,                    1f]])

     return m
  }
}