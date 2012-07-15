//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-09  Jed Young  Creation
//

**
** Vector is a direction with length
**
@Js
const class Vector
{
  const Float x
  const Float y
  const Float z

  **
  ** make from coordinate
  **
  new make(Float x, Float y, Float z)
  {
    this.x = x
    this.y = y
    this.z = z
  }

  override Str toStr() { "Vector($x, $y, $z)" }

//////////////////////////////////////////////////////////////////////////
// arithmetic
//////////////////////////////////////////////////////////////////////////

  **
  ** The parallelogram algebra area
  **
  Float parallelogramArea(Vector v2)
  {
    Vector v1 := this
    return v1.x * v2.y - v2.x * v1.y // a1b2-a2b1
  }

  **
  ** addition
  **
  @Operator
  Vector plus(Vector v2)
  {
    x := this.x + v2.x
    y := this.y + v2.y
    z := this.z + v2.z

    return Vector(x, y, z)
  }

  **
  ** subtract
  **
  @Operator
  Vector minus(Vector v2)
  {
    x := this.x - v2.x
    y := this.y - v2.y
    z := this.z - v2.z

    return Vector(x, y, z)
  }

  **
  ** scalar multiplication
  **
  @Operator
  Vector multFloat(Float n)
  {
    x := n * x
    y := n * y
    z := n * z

    return Vector(x, y, z)
  }

  **
  ** general product
  **
  Vector crossProduct(Vector v2)
  {
    x := y * v2.z - v2.y * this.z // b1c2-b2c1
    y := this.z * v2.x - this.x * v2.z // c1a2-a1c2
    z := this.x * v2.y - v2.x * this.y // a1b2-a2b1

    return Vector(x, y, z)
  }

  **
  ** scalar product
  **
  Float dotProduct(Vector v2)
  {
    x := this.x * v2.x
    y := this.y * v2.y
    z := this.z * v2.z

    return x + y + z
  }

  **
  ** calculates the magnitude of this vector
  **
  Float length()
  {
    (x * x + y * y + z * z).sqrt
  }

  **
  ** returns the unit vector of this vector.
  **
  Vector normalize()
  {
    x := this.x / length
    y := this.y / length
    z := this.z / length

    return Vector(x, y, z)
  }
}