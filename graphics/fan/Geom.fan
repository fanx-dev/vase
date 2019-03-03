//
// Copyright (c) 2008, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   12 Jun 08  Brian Frank  Creation
//

**************************************************************************
** Point
**************************************************************************

**
** Point represents a coordinate in the display space.
**
@Js
@Serializable { simple = true }
const class Point
{
  ** Default instance is 0, 0.
  const static Point defVal := Point(0, 0)

  ** Construct with x, y.
  new make(Int x, Int y) { this.x = x; this.y = y }

  ** Parse from string.  If invalid and checked is
  ** true then throw ParseErr otherwise return null.
  static Point? fromStr(Str s, Bool checked := true)
  {
    try
    {
      comma := s.index(",")
      return make(s[0..<comma].trim.toInt, s[comma+1..-1].trim.toInt)
    }
    catch {}
    if (checked) throw ParseErr("Invalid Point: $s")
    return null
  }

  ** Return 'x+tx, y+ty'
  Point translate(Point t) { make(x+t.x, y+t.y) }

  ** Return hash of x and y.
  override Int hash() { x.xor(y.shiftl(16)) }

  ** Return if obj is same Point value.
  override Bool equals(Obj? obj)
  {
    that := obj as Point
    if (that == null) return false
    return this.x == that.x && this.y == that.y
  }

  ** Return '"x,y"'
  override Str toStr() { "$x,$y" }

  ** X coordinate
  const Int x

  ** Y coordinate
  const Int y
}

**************************************************************************
** Size
**************************************************************************

**
** Size represents the width and height of a rectangle.
**
@Js
@Serializable { simple = true }
const class Size
{
  ** Default instance is 0, 0.
  const static Size defVal := Size(0, 0)

  ** Construct with w, h.
  new make(Int w, Int h) { this.w = w; this.h = h }

  ** Parse from string.  If invalid and checked is
  ** true then throw ParseErr otherwise return null.
  static Size? fromStr(Str s, Bool checked := true)
  {
    try
    {
      comma := s.index(",")
      return make(s[0..<comma].trim.toInt, s[comma+1..-1].trim.toInt)
    }
    catch {}
    if (checked) throw ParseErr("Invalid Size: $s")
    return null
  }

  ** Return '"w,h"'
  override Str toStr() { "$w,$h" }

  ** Return hash of w and h.
  override Int hash() { w.xor(h.shiftl(16)) }

  ** Return if obj is same Size value.
  override Bool equals(Obj? obj)
  {
    that := obj as Size
    if (that == null) return false
    return this.w == that.w && this.h == that.h
  }

  ** Width
  const Int w

  ** Height
  const Int h
}

**************************************************************************
** Rect
**************************************************************************

**
** Represents the x,y coordinate and w,h size of a rectangle.
**
@Js
@Serializable { simple = true }
const class Rect
{
  ** Default instance is 0, 0, 0, 0.
  const static Rect defVal := Rect(0, 0, 0, 0)

  ** Construct with x, y, w, h.
  new make(Int x, Int y, Int w, Int h)
    { this.x = x; this.y = y; this.w = w; this.h = h }

  ** Construct from a Point and Size instance
  new makePosSize(Point p, Size s)
    { this.x = p.x; this.y = p.y; this.w = s.w; this.h= s.h }

  ** Parse from string.  If invalid and checked is
  ** true then throw ParseErr otherwise return null.
  static Rect? fromStr(Str s, Bool checked := true)
  {
    try
    {
      c1 := s.index(",")
      c2 := s.index(",", c1+1)
      c3 := s.index(",", c2+1)
      return make(s[0..<c1].trim.toInt, s[c1+1..<c2].trim.toInt,
                  s[c2+1..<c3].trim.toInt, s[c3+1..-1].trim.toInt)
    }
    catch {}
    if (checked) throw ParseErr("Invalid Rect: $s")
    return null
  }

  ** Get the x, y coordinate of this rectangle.
  Point pos() { Point(x, y) }

  ** center of rectangle
  Point center() { Point(x+(w/2), y+(h/2)) }

  ** Get the w, h size of this rectangle.
  Size size() { Size(w, h) }

  ** Return true if x,y is inside the bounds of this rectangle.
  Bool contains(Int x, Int y)
  {
    return x >= this.x && x <= this.x+w &&
           y >= this.y && y <= this.y+h
  }

  ** Return true if this rectangle intersects any portion of that rectangle
  Bool intersects(Rect that)
  {
    ax1 := this.x; ay1 := this.y; ax2 := ax1 + this.w; ay2 := ay1 + this.h
    bx1 := that.x; by1 := that.y; bx2 := bx1 + that.w; by2 := by1 + that.h
    return !(ax2 <= bx1 || bx2 <= ax1 || ay2 <= by1 || by2 <= ay1)
  }

  ** Compute the intersection between this rectangle and that rectangle.
  ** If there is no intersection, then return `defVal`.
  Rect intersection(Rect that)
  {
    ax1 := this.x; ay1 := this.y; ax2 := ax1 + this.w; ay2 := ay1 + this.h
    bx1 := that.x; by1 := that.y; bx2 := bx1 + that.w; by2 := by1 + that.h
    rx1 := ax1.max(bx1); rx2 := ax2.min(bx2)
    ry1 := ay1.max(by1); ry2 := ay2.min(by2)
    rw := rx2 - rx1
    rh := ry2 - ry1
    if (rw <= 0 || rh <= 0) return defVal
    return make(rx1, ry1, rw, rh)
  }

  ** Compute the union between this rectangle and that rectangle,
  ** which is the bounding box that exactly contains both rectangles.
  Rect union(Rect that)
  {
    ax1 := this.x; ay1 := this.y; ax2 := ax1 + this.w; ay2 := ay1 + this.h
    bx1 := that.x; by1 := that.y; bx2 := bx1 + that.w; by2 := by1 + that.h
    rx1 := ax1.min(bx1); rx2 := ax2.max(bx2)
    ry1 := ay1.min(by1); ry2 := ay2.max(by2)
    rw := rx2 - rx1
    rh := ry2 - ry1
    if (rw <= 0 || rh <= 0) return defVal
    return make(rx1, ry1, rw, rh)
  }

  ** Return '"x,y,w,h"'
  override Str toStr() { return "$x,$y,$w,$h" }

  ** Return hash of x, y, w, and h.
  override Int hash()
  {
    x.xor(y.shiftl(8)).xor(w.shiftl(16)).xor(w.shiftl(24))
  }

  ** Return if obj is same Rect value.
  override Bool equals(Obj? obj)
  {
    that := obj as Rect
    if (that == null) return false
    return this.x == that.x && this.y == that.y &&
           this.w == that.w && this.h == that.h
  }

  ** X coordinate
  const Int x

  ** Y coordinate
  const Int y

  ** Width
  const Int w

  ** Height
  const Int h
}