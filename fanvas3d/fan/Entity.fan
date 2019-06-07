//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fanvasMath
using fanvasOpenGl

**
** 3D object Model
**
@Js
class Entity : Node
{
  ArrayBuffer? vertices
  internal GlBuffer? vertexPositionBuffer
  internal Int vertexPositionAttribute

  Material? material
}