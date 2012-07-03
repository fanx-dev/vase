//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-13  Jed Young  Creation
//


**
** represent paths through the two-dimensional coordinate system
**
@Js
class Path
{
  PathStep[] steps := [,]

  This clear() { steps.clear; return this }
  Bool contains(Float x, Float y) { return GfxEnv.cur.contains(this, x, y); }

  This close()
  {
    steps.add(PathClose())
    return this
  }
  This moveTo(Float x, Float y)
  {
    steps.add(PathMoveTo { it.x=x; it.y=y })
    return this
  }
  This lineTo(Float x, Float y)
  {
    steps.add(PathLineTo { it.x=x; it.y=y })
    return this
  }
  This quadTo(Float cx, Float cy, Float x, Float y)
  {
    steps.add(PathQuadTo { it.cx=cx; it.cy=cy; it.x=x; it.y=y })
    return this
  }
  This cubicTo(Float cx1, Float cy1, Float cx2, Float cy2, Float x, Float y)
  {
    steps.add(PathCubicTo { it.cx1=cx1; it.cy1=cy1; it.cx2=cx2; it.cy2=cy2; it.x=x; it.y=y })
    return this
  }
}

**************************************************************************
** step
**************************************************************************
@NoDoc
@Js
const mixin PathStep
{
}
@NoDoc
@Js
const class PathMoveTo : PathStep
{
  const Float x; const Float y
  new make(|This| f) { f(this) }
}
@NoDoc
@Js
const class PathLineTo : PathStep
{
  const Float x; const Float y
  new make(|This| f) { f(this) }
}
@NoDoc
@Js
const class PathQuadTo : PathStep
{
  const Float cx; const Float cy; const Float x; const Float y
  new make(|This| f) { f(this) }
}
@NoDoc
@Js
const class PathCubicTo : PathStep
{
  const Float cx1; const Float cy1; const Float cx2; const Float cy2; const Float x; const Float y
  new make(|This| f) { f(this) }
}

@NoDoc
@Js
const class PathClose : PathStep
{
}