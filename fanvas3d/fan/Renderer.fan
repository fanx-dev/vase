//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fanvasMath
using fanvasOpenGl
using fanvasArray

**
** Render the Scene
**
@Js
class Renderer
{
  **
  ** current GL context
  **
  GlContext? gl

  **
  ** view projection
  **
  Matrix projection

  **
  ** default program
  **
  Program program

  ** viewport width
  Int width := 100

  ** viewport height
  Int height := 100

  new make(|This|f)
  {
    f(this)
  }

  **
  ** init env
  **
  Void init(Scene scene)
  {
    gl.clearColor(0f, 0f, 0.3f, 1f)
    gl.enable(GlEnum.depthTest)
    gl.viewport(0, 0, width, height)

    //init program
    this.program.init(gl)
    scene.root.each |g|
    {
      if (g.program != null)
      {
        g.program.init(gl)
      }
    }
  }

  **
  ** do scene render
  **
  Void render(Scene scene)
  {
    // clear background
    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))

    TransformStack mvTrans := TransformStack()
    Program? program
    scene.root.each |g|
    {
      program = g.program ?: this.program
      program.useProgram

      //do transform
      if (g.transform != null)
      {
        mvTrans.push
        mvTrans.mult(g.transform.matrix)
      }

      //draw primitive obj
      if (g is Entity)
      {
        Entity obj := g
        initBuffer(obj, program)
        setMatrixUniforms(scene.camera, mvTrans.top, program)
        renderObject(obj, program)
      }

      //restore transform
      if (g.transform != null)
      {
        mvTrans.pop
      }
    }
  }

  **
  ** set the transform matrix
  **
  private Void setMatrixUniforms(Camera camera, Matrix mvMatrix, Program program)
  {
    pMatrixUniform := program.getUniformLocation("uPMatrix")
    mvMatrixUniform := program.getUniformLocation("uMVMatrix")

    Float[] mvMatrixA  := (camera.transform.matrix * mvMatrix).flatten
    Float[] pMatrixA  := projection.flatten

    gl.uniformMatrix4fv(pMatrixUniform, false, ArrayBuffer.makeFloat(pMatrixA))
    gl.uniformMatrix4fv(mvMatrixUniform, false, ArrayBuffer.makeFloat(mvMatrixA))
  }

  **
  ** draw primitive object
  **
  private Void renderObject(Entity obj, Program program)
  {
    //prepare program
    obj.vertexPositionAttribute = program.getAttribLocation("aVertexPosition")
    gl.enableVertexAttribArray(obj.vertexPositionAttribute)

    //bind buffer
    gl.bindBuffer(GlEnum.arrayBuffer, obj.vertexPositionBuffer)
    gl.vertexAttribPointer(obj.vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)

    //draw
    gl.drawArrays(GlEnum.triangles, 0, 3)
  }

  **
  ** init buffer
  **
  private Void initBuffer(Entity obj, Program program)
  {
    if (obj.vertexPositionBuffer != null) return

    //set buffer
    obj.vertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, obj.vertexPositionBuffer)
    arrayBuffer := ArrayBuffer.makeFloat(obj.vertices)
    gl.bufferData(GlEnum.arrayBuffer, arrayBuffer, GlEnum.staticDraw)
  }
}