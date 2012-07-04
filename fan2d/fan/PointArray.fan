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
  abstract Int get(Int i)
  abstract Void set(Int i, Int v)
}