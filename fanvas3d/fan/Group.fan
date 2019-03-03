//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fanvasMath


@Js
virtual class Node
{
  Transform3D? transform
  Program? program
}

@Js
class Group : Node
{
  private Node[] children := Node[,]

  Void each(|Node| f)
  {
    f(this)
    children.each |g|
    {
      if (g is Group)
      {
        ((Group)g).each(f)
      }
      else if (g is Entity)
      {
        f(g)
      }
    }
  }

  Void add(Node g) { children.add(g) }
}