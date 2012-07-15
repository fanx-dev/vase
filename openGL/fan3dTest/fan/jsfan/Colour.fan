#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using fogl
using fan3dMath
using fan3dMath::Transform3D as Transform
using array

**
** fan D:/code/Hg/fan3d/jsTest/fan/jsfan/Colour.fan
**
@Js
class Colour : GlDisplay
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
  GlBuffer? triangleVertexColorBuffer
  GlBuffer? squareVertexPositionBuffer;
  GlBuffer? squareVertexColorBuffer;

  Int? vertexPositionAttribute
  Int? vertexColorAttribute

  GlUniformLocation? pMatrixUniform
  GlUniformLocation? mvMatrixUniform

  Float[]? mvMatrix
  Float[]? pMatrix

  override Void onPaint(GlContext gl)
  {
    this.gl = gl
    pMatrix = Transform.makePerspective(45f, w.toFloat/h.toFloat, 0.1f, 100.0f).flatten
    transform := Transform()
    mvMatrix = transform.translate(-1.5f, 0.0f, -7.0f).top.flatten

    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))
    setMatrixUniforms

    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)

    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexColorBuffer);
    gl.vertexAttribPointer(vertexColorAttribute, 4, GlEnum.float, false, 0, 0)

    gl.drawArrays(GlEnum.triangles, 0, 3)


    mvMatrix = transform.translate(3.0f, 0.0f, 0.0f).top.flatten
    gl.bindBuffer(GlEnum.arrayBuffer, squareVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)

    gl.bindBuffer(GlEnum.arrayBuffer, squareVertexColorBuffer)
    gl.vertexAttribPointer(vertexColorAttribute, 4, GlEnum.float, false, 0, 0)

    setMatrixUniforms
    gl.drawArrays(GlEnum.triangleStrip, 0, 4)
  }

  private Void setMatrixUniforms()
  {
    gl.uniformMatrix4fv(pMatrixUniform, false, ArrayBuffer.makeFloat(pMatrix))
    gl.uniformMatrix4fv(mvMatrixUniform, false, ArrayBuffer.makeFloat(mvMatrix))
  }

  private Void initShader()
  {
    fStr := Str<|
                  #ifdef GL_ES
                  precision highp float;
                  #endif

                  varying vec4 vColor;

                  void main(void) {
                    gl_FragColor = vColor;
                  }
                 |>

    vStr := Str<|   attribute vec3 aVertexPosition;
                    attribute vec4 aVertexColor;

                    uniform mat4 uMVMatrix;
                    uniform mat4 uPMatrix;

                    varying vec4 vColor;

                    void main(void) {
                      gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
                      vColor = aVertexColor;
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

    vertexColorAttribute = gl.getAttribLocation(shaderProgram, "aVertexColor")
    gl.enableVertexAttribArray(vertexColorAttribute)

    pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix")
    mvMatrixUniform = gl.getUniformLocation(shaderProgram, "uMVMatrix")
  }

  private Void initBuffer()
  {
    //triangle
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

    triangleVertexColorBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexColorBuffer)
    Float[] colors :=
    [
        1.0f, 0.0f, 0.0f, 1.0f,
        0.0f, 1.0f, 0.0f, 1.0f,
        0.0f, 0.0f, 1.0f, 1.0f,
    ]
    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(colors), GlEnum.staticDraw)

    //square
    squareVertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, squareVertexPositionBuffer)
    vertices = [
         1.0f,  1.0f,  0.0f,
        -1.0f,  1.0f,  0.0f,
         1.0f, -1.0f,  0.0f,
        -1.0f, -1.0f,  0.0f,
    ]
    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(vertices), GlEnum.staticDraw)

    squareVertexColorBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, squareVertexColorBuffer)
    colors = [,]
    for (i := 0; i < 4; i++) {
      colors.addAll([0.5f, 0.5f, 1.0f, 1.0f])
    }
    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(colors), GlEnum.staticDraw);
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

