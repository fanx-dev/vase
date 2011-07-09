//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using fogl

**
** fan D:/code/Hg/fan3d/fogl/GlTest.fan
**
@Js
class Display : GlDisplay
{
  Void main()
  {
    Display().open
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
  Buffer? triangleVertexPositionBuffer := Buffer()
  Int? vertexPositionAttribute := 0

  UniformLocation? pMatrixUniform
  UniformLocation? mvMatrixUniform

  override Void onPaint(GlContext gl)
  {
    this.gl = gl

    //echo(triangleVertexPositionBuffer->val)
    //echo(vertexPositionAttribute)
    //echo("----")


    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))
    setMatrixUniforms

    //gl.enableVertexAttribArray(vertexPositionAttribute)

    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)

    gl.drawArrays(GlEnum.triangles, 0, 3)
  }

  private Void setMatrixUniforms()
  {
    Float[] mvMatrix  :=
    [
       1f,  0f,  0f, 0f,
       0f,  1f,  0f, 0f,
       0f,  0f,  1f, 0f,
     -1.5f, 0f, -7f, 1f,
    ]

    Float[] pMatrix  :=
    [
       2.4142136573791504f,  0f,                   0f,                      0f,
       0f,                   2.4142136573791504f,  0f,                      0f,
       0f,                   0f,                   -1.0020020008087158f,   -1f,
       0f,                   0f,                    -0.20020020008087158f,  0f,
    ]

    gl.uniformMatrix4fv(pMatrixUniform, false, ArrayBuffer.makeFloat(pMatrix))
    gl.uniformMatrix4fv(mvMatrixUniform, false, ArrayBuffer.makeFloat(mvMatrix))
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

    if (!gl.getProgramParameter(shaderProgram, GlEnum.linkStatus)) {
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

  private Shader getShader(GlEnum type, Str source)
  {
    shader := gl.createShader(type)

    gl.shaderSource(shader, source)
    gl.compileShader(shader)

    if (!gl.getShaderParameter(shader, GlEnum.compileStatus)) {
        throw Err(gl.getShaderInfoLog(shader))
    }

    return shader
  }
}

