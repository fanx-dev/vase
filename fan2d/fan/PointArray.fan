//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-02  Jed Young  Creation
//


**
** PointArray
**
@Js
mixin PointArray
{
  abstract Int size()
  static new make(Int size) { GfxEnv.cur.makePointArray(size) }

  abstract Int getX(Int i)
  abstract Void setX(Int i, Int v)

  abstract Int getY(Int i)
  abstract Void setY(Int i, Int v)
}