//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fan3dMath

class Group
{
  Transform3D? transform

  private Group[] children := Group[,]
  Light[] lights := Light[,]

  Void each(|Group| f)
  {
    f(this)
    children.each |g|
    {
      g.each(f)
    }
  }

  Void add(Group g) { children.add(g) }

}