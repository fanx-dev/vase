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
  Buffer? triangleVertexPositionBuffer
  Int? vertexPositionAttribute

  override Void onPaint(GlContext gl)
  {
    this.gl = gl

    echo(triangleVertexPositionBuffer->val)
    echo(vertexPositionAttribute)


    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))

    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)
    gl.drawArrays(GlEnum.triangles, 0, 3)
  }

  private Void initShader()
  {
    fStr := Str<|
                  varying vec4 vertColor;

                  void main(void) {
                      gl_FragColor = vertColor;
                  }
                 |>

    vStr := Str<|     varying vec4 vertColor;
                      attribute vec3 aVertexPosition;

                      //uniform mat4 uMVMatrix;
                      //uniform mat4 uPMatrix;

                      void main(void) {
                          gl_Position = vec4(aVertexPosition, 1.0);
                          vertColor = vec4(0.6, 0.3, 0.4, 1.0);
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
  }

  private Void initBuffer()
  {
    triangleVertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    Float[] vertices :=
    [
       0.0f,  1.0f,  1.0f,
      -1.0f, -1.0f,  0.0f,
       1.0f, -1.0f,  -1.0f
    ]

    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(vertices), GlEnum.staticDraw)
  }

  private Shader getShader(GlEnum type, Str source)
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

