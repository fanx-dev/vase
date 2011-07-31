#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-16  Jed Young  Creation
//

using fogl
using fan3dMath

**
** fan D:/code/Hg/fan3d/jsTest/fan/jsfan/RealObject.fan
**
@Js
class RealObject : GlDisplay
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

  GlBuffer? pyramidVertexPositionBuffer
  GlBuffer? pyramidVertexColorBuffer
  GlBuffer? cubeVertexPositionBuffer
  GlBuffer? cubeVertexColorBuffer
  GlBuffer? cubeVertexIndexBuffer
  Int[]? cubeVertexIndices

  Int? vertexPositionAttribute
  Int? vertexColorAttribute

  GlUniformLocation? pMatrixUniform
  GlUniformLocation? mvMatrixUniform

  Float[]? mvMatrix
  Float[]? pMatrix

  Float rPyramid := 0f
  Float rCube := 0f

  override Void onPaint(GlContext gl)
  {
    this.gl = gl
    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))
    pMatrix = Transform.makePerspective(45f, w.toFloat/h.toFloat, 0.1f, 100.0f).flatten
    transform := Transform()

    //triangle
    transform.translate(-1.5f, 0.0f, -8.0f)
    transform.push
    transform.rotate(rPyramid, 0f, 1f, 0f)
    mvMatrix = transform.top.flatten

    gl.bindBuffer(GlEnum.arrayBuffer, pyramidVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)
    gl.bindBuffer(GlEnum.arrayBuffer, pyramidVertexColorBuffer);
    gl.vertexAttribPointer(vertexColorAttribute, 4, GlEnum.float, false, 0, 0)

    setMatrixUniforms
    gl.drawArrays(GlEnum.triangles, 0, 12)
    transform.pop

    //square
    transform.translate(3.0f, 0.0f, 0.0f)
    transform.push
    transform.rotate(rCube, 1f, 1f, 1f)
    mvMatrix = transform.top.flatten

    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)
    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexColorBuffer)
    gl.vertexAttribPointer(vertexColorAttribute, 4, GlEnum.float, false, 0, 0)
    gl.bindBuffer(GlEnum.elementArrayBuffer, cubeVertexIndexBuffer)

    setMatrixUniforms
    gl.drawElements(GlEnum.triangles, cubeVertexIndices.size, GlEnum.unsignedShort, 0)
    transform.pop

    animate
  }

  private Void setMatrixUniforms()
  {
    gl.uniformMatrix4fv(pMatrixUniform, false, ArrayBuffer.makeFloat(pMatrix))
    gl.uniformMatrix4fv(mvMatrixUniform, false, ArrayBuffer.makeFloat(mvMatrix))
  }

  Int lastTime := 0
  private Void animate()
  {
    timeNow := DateTime.nowTicks / 1000000
    if (lastTime != 0)
    {
      elapsed := timeNow - lastTime

      rPyramid += (90 * elapsed).toFloat / 1000.0f
      rCube += (75 * elapsed).toFloat / 1000.0f
    }
    lastTime = timeNow;
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
    pyramidVertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, pyramidVertexPositionBuffer)
    Float[] vertices :=
    [
      // Front face
       0.0f,  1.0f,  0.0f,
      -1.0f, -1.0f,  1.0f,
       1.0f, -1.0f,  1.0f,
      // Right face
       0.0f,  1.0f,  0.0f,
       1.0f, -1.0f,  1.0f,
       1.0f, -1.0f, -1.0f,
      // Back face
       0.0f,  1.0f,  0.0f,
       1.0f, -1.0f, -1.0f,
      -1.0f, -1.0f, -1.0f,
      // Left face
       0.0f,  1.0f,  0.0f,
      -1.0f, -1.0f, -1.0f,
      -1.0f, -1.0f,  1.0f,
    ]

    arrayBuffer := ArrayBuffer.makeFloat(vertices)
    gl.bufferData(GlEnum.arrayBuffer, arrayBuffer, GlEnum.staticDraw)

    pyramidVertexColorBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, pyramidVertexColorBuffer)
    Float[] colors :=
    [
      // Front face
      1.0f, 0.0f, 0.0f, 1.0f,
      0.0f, 1.0f, 0.0f, 1.0f,
      0.0f, 0.0f, 1.0f, 1.0f,
      // Right face
      1.0f, 0.0f, 0.0f, 1.0f,
      0.0f, 0.0f, 1.0f, 1.0f,
      0.0f, 1.0f, 0.0f, 1.0f,
      // Back face
      1.0f, 0.0f, 0.0f, 1.0f,
      0.0f, 1.0f, 0.0f, 1.0f,
      0.0f, 0.0f, 1.0f, 1.0f,
      // Left face
      1.0f, 0.0f, 0.0f, 1.0f,
      0.0f, 0.0f, 1.0f, 1.0f,
      0.0f, 1.0f, 0.0f, 1.0f,
    ]
    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(colors), GlEnum.staticDraw)

    //square
    cubeVertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexPositionBuffer)
    vertices = [
      // Front face
      -1.0f, -1.0f,  1.0f,
       1.0f, -1.0f,  1.0f,
       1.0f,  1.0f,  1.0f,
      -1.0f,  1.0f,  1.0f,

      // Back face
      -1.0f, -1.0f, -1.0f,
      -1.0f,  1.0f, -1.0f,
       1.0f,  1.0f, -1.0f,
       1.0f, -1.0f, -1.0f,

      // Top face
      -1.0f,  1.0f, -1.0f,
      -1.0f,  1.0f,  1.0f,
       1.0f,  1.0f,  1.0f,
       1.0f,  1.0f, -1.0f,

      // Bottom face
      -1.0f, -1.0f, -1.0f,
       1.0f, -1.0f, -1.0f,
       1.0f, -1.0f,  1.0f,
      -1.0f, -1.0f,  1.0f,

      // Right face
       1.0f, -1.0f, -1.0f,
       1.0f,  1.0f, -1.0f,
       1.0f,  1.0f,  1.0f,
       1.0f, -1.0f,  1.0f,

      // Left face
      -1.0f, -1.0f, -1.0f,
      -1.0f, -1.0f,  1.0f,
      -1.0f,  1.0f,  1.0f,
      -1.0f,  1.0f, -1.0f,
    ]
    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(vertices), GlEnum.staticDraw)

    cubeVertexColorBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexColorBuffer)


    colors2 := [
      [1.0f, 0.0f, 0.0f, 1.0f],     // Front face
      [1.0f, 1.0f, 0.0f, 1.0f],     // Back face
      [0.0f, 1.0f, 0.0f, 1.0f],     // Top face
      [1.0f, 0.5f, 0.5f, 1.0f],     // Bottom face
      [1.0f, 0.0f, 1.0f, 1.0f],     // Right face
      [0.0f, 0.0f, 1.0f, 1.0f],     // Left face
    ];
    unpackedColors := [,]
    colors2.each | color, i |
    {
      for (j := 0; j < 4; j++)
      {
        unpackedColors.addAll(color)
      }
    }
    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(unpackedColors), GlEnum.staticDraw);

    cubeVertexIndexBuffer = gl.createBuffer()
    gl.bindBuffer(GlEnum.elementArrayBuffer, cubeVertexIndexBuffer)
    cubeVertexIndices = [
      0, 1, 2,      0, 2, 3,    // Front face
      4, 5, 6,      4, 6, 7,    // Back face
      8, 9, 10,     8, 10, 11,  // Top face
      12, 13, 14,   12, 14, 15, // Bottom face
      16, 17, 18,   16, 18, 19, // Right face
      20, 21, 22,   20, 22, 23  // Left face
    ]
    gl.bufferData(GlEnum.elementArrayBuffer, ArrayBuffer.makeShort(cubeVertexIndices), GlEnum.staticDraw)

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

