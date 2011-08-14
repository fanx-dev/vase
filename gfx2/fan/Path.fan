//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-11  Jed Young  Creation
//

using gfx

**
** represent paths through the two-dimensional coordinate system
**
class Path
{
  PathStep[] steps := [,]

  This clear() { steps.clear; return this }

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
  This arcTo(Float x1, Float y1, Float x2, Float y2, Float radius)
  {
    steps.add(PathArcTo { it.x1=x1; it.y1=y1; it.x2=x2; it.y2=y2; it.radius=radius })
    return this
  }
}

**************************************************************************
** step
**************************************************************************

const mixin PathStep
{
}

const class PathMoveTo : PathStep
{
  const Float x; const Float y
  new make(|This| f) { f(this) }
}

const class PathLineTo : PathStep
{
  const Float x; const Float y
  new make(|This| f) { f(this) }
}

const class PathQuadTo : PathStep
{
  const Float cx; const Float cy; const Float x; const Float y
  new make(|This| f) { f(this) }
}

const class PathCubicTo : PathStep
{
  const Float cx1; const Float cy1; const Float cx2; const Float cy2; const Float x; const Float y
  new make(|This| f) { f(this) }
}

const class PathArcTo : PathStep
{
  const Float x1; const Float y1; const Float x2; const Float y2; const Float radius
  new make(|This| f) { f(this) }
}