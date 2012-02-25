//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fan3dMath
using fogl
using array

class Scene
{
  private GlContext? gl

  Camera camera := Camera()
  Group root := Group()

  Void init(GlContext gl)
  {
    this.gl = gl
    root.each |g|
    {
      if (g is Object)
      {
        Object obj := g
        obj.init(gl)
      }
    }
  }

  Void paint(GlContext gl)
  {
    root.each |g|
    {
      if (g is Object)
      {
        Object obj := g
        setMatrixUniforms(obj.transform, obj.program)
        obj.paint(gl)
      }
    }
  }

  private Void setMatrixUniforms(Transform3D transform, Program program)
  {
    Float[] mvMatrix  := (camera.transform.top *transform.top).flatten
    Float[] pMatrix  := camera.projection.flatten

    gl.uniformMatrix4fv(program.pMatrixUniform, false, ArrayBuffer.makeFloat(pMatrix))
    gl.uniformMatrix4fv(program.mvMatrixUniform, false, ArrayBuffer.makeFloat(mvMatrix))
  }
}