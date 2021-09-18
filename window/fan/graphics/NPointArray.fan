//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-9-9  Jed Young  Creation
//
using vaseGraphics

**
** High Performance Point Array
**
class NPointArray : PointArray
{
  private Array<Int> data
  new alloc(Int size) { data = Array<Int>(size*2) }

  override Int size() { data.size/2 }

  override Int getX(Int i) { data[i/2] }
  override Void setX(Int i, Int v) { data[i/2] = v }

  override Int getY(Int i) { data[i/2+1] }
  override Void setY(Int i, Int v) { data[i/2+1] = v }
}