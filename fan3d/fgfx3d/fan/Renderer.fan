//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fgfxMath
using fgfxOpenGl
using fgfxArray

@Js
class Renderer
{
  GlContext? gl

  //GlUniformLocation? pMatrixUniform
  //GlUniformLocation? mvMatrixUniform
  Int width := 100
  Int height := 100

  Void init(Scene scene)
  {
    gl.clearColor(0f, 0f, 0.3f, 1f)
    gl.enable(GlEnum.depthTest)
    gl.viewport(0, 0, width, height)

    scene.root.each |g|
    {
      if (g is Object)
      {
        Object obj := g
        obj.program.init(gl)
      }
    }
  }

  Void render(Scene scene)
  {
    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))
    scene.root.each |g|
    {
      if (g is Object)
      {
        Object obj := g
        initObject(obj)
        setMatrixUniforms(scene.camera, obj.transform, obj.program)
        renderObject(obj)
      }
    }
  }

  private Void setMatrixUniforms(Camera camera, Transform3D transform, Program program)
  {
    pMatrixUniform := program.getUniformLocation("uPMatrix")
    mvMatrixUniform := program.getUniformLocation("uMVMatrix")

    Float[] mvMatrix  := (camera.transform.top *transform.top).flatten
    Float[] pMatrix  := camera.projection.flatten

    gl.uniformMatrix4fv(pMatrixUniform, false, ArrayBuffer.makeFloat(pMatrix))
    gl.uniformMatrix4fv(mvMatrixUniform, false, ArrayBuffer.makeFloat(mvMatrix))
  }

  private Void renderObject(Object obj)
  {
    gl.bindBuffer(GlEnum.arrayBuffer, obj.vertexPositionBuffer)
    gl.vertexAttribPointer(obj.vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)

    gl.drawArrays(GlEnum.triangles, 0, 3)
  }

  private Void initObject(Object obj)
  {
    if (obj.vertexPositionBuffer != null) return
    obj.vertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, obj.vertexPositionBuffer)
    arrayBuffer := ArrayBuffer.makeFloat(obj.vertices)
    gl.bufferData(GlEnum.arrayBuffer, arrayBuffer, GlEnum.staticDraw)

    obj.program.init(gl)
    obj.program.useProgram
    obj.vertexPositionAttribute = obj.program.getAttribLocation("aVertexPosition")
    gl.enableVertexAttribArray(obj.vertexPositionAttribute)
  }
}