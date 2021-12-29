//
// Copyright (c) 2017, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   2 May 2017  Brian Frank  Creation
//

**
** Transform models an affine transformation matrix:
**
**   |a  c  e|
**   |b  d  f|
**   |0  0  1|
**
@NoDoc @Js
const class Transform2D
{
  ** Parse from SVG string format
  static Transform2D? fromStr(Str s, Bool checked := true)
  {
    try
    {
      Transform2D? t := null
      s.split(')').each |func|
      {
        if (func.startsWith(",")) func = func[1..-1].trim
        if (func.isEmpty) return
        r := parseFunc(func)
        t = t == null ? r : t * r
      }
      if (t != null) return t
    }
    catch (Err e) {}
    if (checked) throw ParseErr("Transform: $s")
    return null
  }

  ** Parse func, trailing ) already stripped from split
  private static Transform2D parseFunc(Str s)
  {
    op := s.index("(") ?: throw Err()
    name := s[0..<op].trim
    argsStr := s[op+1..-1].trim
    args :=  GeomUtil.parseFloatList(argsStr)
    switch (name)
    {
      case "matrix":    return make(args[0], args[1], args[2], args[3], args[4], args[5])
      case "translate": return makeTranslate(args[0], args.getSafe(1) ?: 0f)
      case "scale":     return makeScale(args[0], args.getSafe(1) ?: args[0])
      case "rotate":    return makeRotate(args[0], args.getSafe(1), args.getSafe(2))
      case "skewX":     return makeSkewX(args[0])
      case "skewY":     return makeSkewY(args[0])
      default:          throw Err(name)
    }
  }

  ** Translate factory
  Transform2D translate(Float tx, Float ty)
  {
    makeTranslate(tx, ty) * this
  }

  ** Scale
  Transform2D scale(Float sx, Float sy)
  {
    makeScale(sx, sy) * this
  }

  ** Rotate angle in degrees
  Transform2D rotate(Float angle, Float? cx := null, Float? cy := null)
  {
    makeRotate(angle, cx, cy) * this
  }

  ** Translate factory
  static Transform2D makeTranslate(Float tx, Float ty)
  {
    make(1f, 0f, 0f, 1f, tx, ty)
  }

  ** Scale
  static Transform2D makeScale(Float sx, Float sy)
  {
    make(sx, 0f, 0f, sy, 0f, 0f)
  }

  ** Rotate angle in degrees
  static Transform2D makeRotate(Float angle, Float? cx := null, Float? cy := null)
  {
    a := angle.toRadians
    acos := a.cos
    asin := a.sin
    rot := make(acos, asin, -asin, acos, 0f, 0f)
    if (cx == null) return rot
    return makeTranslate(cx, cy) * rot * makeTranslate(-cx, -cy)
  }

  ** Skew x by angle in degrees
  static Transform2D makeSkewX(Float angle)
  {
    a := angle.toRadians
    return make(1f, 0f, a.tan, 1f, 0f, 0f)
  }

  ** Skew y by angle in degrees
  static Transform2D makeSkewY(Float angle)
  {
    a := angle.toRadians
    return make(1f, a.tan, 0f, 1f, 0f, 0f)
  }

  static Transform2D makeIndentity() {
    make(1f, 0f, 0f, 1f, 0f, 0f)
  }

  ** Construct from matrix values
  new make(Float a, Float b, Float c, Float d, Float e, Float f)
  {
    this.a = a; this.c = c; this.e = e
    this.b = b; this.d = d; this.f = f
  }

  ** Multiply this matrix by given matrix and return result as new instance
  @Operator This mult(Transform2D that)
  {
    make(this.a * that.a + this.c * that.b + this.e * 0f,  // a
         this.b * that.a + this.d * that.b + this.f * 0f,  // b
         this.a * that.c + this.c * that.d + this.e * 0f,  // c
         this.b * that.c + this.d * that.d + this.f * 0f,  // d
         this.a * that.e + this.c * that.f + this.e * 1f,  // e
         this.b * that.e + this.d * that.f + this.f * 1f)  // f
  }

  **
  ** transform the coordinate using current matrix.
  ** x: xy[0], y: xy[1]. The result will rewrite the list
  **
  Void transform(Float[] xy)
  {
    x := xy[0]
    y := xy[1]
    x2 := a*x + c*y + e
    y2 := b*x + d*y + f
    xy[0] = x2
    xy[1] = y2
  }

  override Str toStr()
  {
    s := StrBuf()
    s.add("matrix(")
     .add(f2s(a)).addChar(' ')
     .add(f2s(b)).addChar(' ')
     .add(f2s(c)).addChar(' ')
     .add(f2s(d)).addChar(' ')
     .add(f2s(e)).addChar(' ')
     .add(f2s(f)).addChar(')')
    return s.toStr
  }

  private static Str f2s(Float f) { f.toLocale("0.#####") }

  const Float a
  const Float b
  const Float c
  const Float d
  const Float e
  const Float f
}
