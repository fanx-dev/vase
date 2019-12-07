#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using vaseOpenGl
using vaseMath
using vaseMath::Transform3D as Transform

**
** fan D:/code/Hg/fan3d/jsTest/fan/jsfan/Triangle.fan
**
@Js
class Triangle : GlDisplay
{
  Void main()
  {
    open
  }

  override Void init(GlContext gl)
  {
    this.gl = gl

    initShader
    initBuffer

    gl.clearColor(0f, 0f, 0.3f, 1f)
    gl.enable(GlEnum.depthTest)
    gl.viewport(0, 0, w, h)
  }

  GlContext? gl
  GlBuffer? triangleVertexPositionBuffer
  Int? vertexPositionAttribute := 0

  GlUniformLocation? pMatrixUniform
  GlUniformLocation? mvMatrixUniform

  override Void onPaint(GlContext gl)
  {
    this.gl = gl

    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))
    setMatrixUniforms

    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)

    gl.drawArrays(GlEnum.triangles, 0, 3)
  }

  private Void setMatrixUniforms()
  {
    FloatArray mvMatrix  := Transform().translate(-1.5f, 0.0f, -7.0f).matrix.flatten
    FloatArray pMatrix  := Transform.makePerspective(45f, w.toFloat/h.toFloat, 0.1f, 100.0f).flatten

    gl.uniformMatrix4fv(pMatrixUniform, false, ArrayBuffer.makeFloatArray(pMatrix))
    gl.uniformMatrix4fv(mvMatrixUniform, false, ArrayBuffer.makeFloatArray(mvMatrix))
  }

  private Void initShader()
  {
    fStr := Str<|
                 #ifdef GL_ES
                 precision highp float;
                 #endif

                 varying vec4 vertColor;

                 void main(void) {
                    gl_FragColor = vertColor;
                 }
                 |>

    vStr := Str<|varying vec4 vertColor;
                 attribute vec3 aVertexPosition;

                 uniform mat4 uMVMatrix;
                 uniform mat4 uPMatrix;

                 void main(void) {
                    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
                    vertColor = vec4(0.8, 0.3, 0.9, 1.0);
                 }
                 |>

    fragmentShader := getShader(GlEnum.fragmentShader, fStr)
    vertexShader := getShader(GlEnum.vertexShader, vStr)

    shaderProgram := gl.createProgram
    gl.attachShader(shaderProgram, vertexShader)
    gl.attachShader(shaderProgram, fragmentShader)
    gl.linkProgram(shaderProgram)
    gl.validateProgram(shaderProgram)

    if (gl.getProgramParameter(shaderProgram, GlEnum.linkStatus) == 0) {
        throw Err("Could not initialise shaders")
    }

    gl.useProgram(shaderProgram)
    vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition")
    gl.enableVertexAttribArray(vertexPositionAttribute)

    pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix")
    mvMatrixUniform = gl.getUniformLocation(shaderProgram, "uMVMatrix")
  }

  private Void initBuffer()
  {
    triangleVertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    Float[] vertices :=
    [
      0.0f,  1.0f,  0.0f,
     -1.0f, -1.0f,  0.0f,
      1.0f, -1.0f,  0.0f,
    ]

    arrayBuffer := ArrayBuffer.makeFloat(vertices)
    gl.bufferData(GlEnum.arrayBuffer, arrayBuffer, GlEnum.staticDraw)
  }

  private GlShader getShader(GlEnum type, Str source)
  {
    shader := gl.createShader(type)

    gl.shaderSource(shader, source)
    gl.compileShader(shader)

    if (gl.getShaderParameter(shader, GlEnum.compileStatus) == 0) {
        throw Err(gl.getShaderInfoLog(shader))
    }

    return shader
  }
}

