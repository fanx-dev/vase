#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-29  Jed Young  Creation
//

using fogl
using fan3dMath

**
** fan D:/code/Hg/fan3d/jsTest/fan/jsfan/Texture.fan
**
@Js
class Textures : GlDisplay
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
    initTexture

    gl.clearColor(0f, 0f, 0.3f, 1f)
    gl.enable(GlEnum.depthTest)
    gl.viewport(0, 0, w, h)
  }

  Void initTexture()
  {
    neheTexture = gl.createTexture()
    image := Image(`/public/nehe.gif`)
    image.load
    {
      gl.bindTexture(GlEnum.texture2d, neheTexture)
      gl.pixelStorei(GlEnum.unpackFlipYWebgl, 1)
      gl.texImage2D(GlEnum.texture2d, 0, GlEnum.rgba, GlEnum.rgba, GlEnum.unsignedByte, image)
      gl.texParameteri(GlEnum.texture2d, GlEnum.textureMagFilter, GlEnum.nearest.val)
      gl.texParameteri(GlEnum.texture2d, GlEnum.textureMinFilter, GlEnum.nearest.val)
      gl.bindTexture(GlEnum.texture2d, null)
    }
  }

  GlContext? gl

  Buffer? cubeVertexTextureCoordBuffer
  Buffer? cubeVertexPositionBuffer
  Buffer? cubeVertexIndexBuffer
  Int[]? cubeVertexIndices

  Int? vertexPositionAttribute
  Int? textureCoordAttribute

  UniformLocation? pMatrixUniform
  UniformLocation? mvMatrixUniform
  UniformLocation? samplerUniform

  Float[]? mvMatrix
  Float[]? pMatrix

  Float xRot := 0f
  Float yRot := 0f
  Float zRot := 0f

  Texture? neheTexture

  override Void onPaint(GlContext gl)
  {
    this.gl = gl
    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))
    pMatrix = Transform.makePerspective(45f, w.toFloat/h.toFloat, 0.1f, 100.0f).flatten
    transform := Transform()

    //square
    transform.translate(0.0f, 0.0f, -5.0f)
    transform.rotate(xRot, 1f, 0f, 0f)
    transform.rotate(yRot, 0f, 1f, 0f)
    transform.rotate(zRot, 0f, 0f, 1f)
    mvMatrix = transform.top.flatten

    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)
    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexTextureCoordBuffer)
    gl.vertexAttribPointer(textureCoordAttribute, 2, GlEnum.float, false, 0, 0)

    gl.activeTexture(GlEnum.texture0)
    gl.bindTexture(GlEnum.texture2d, neheTexture)
    gl.uniform1i(samplerUniform, 0)

    gl.bindBuffer(GlEnum.elementArrayBuffer, cubeVertexIndexBuffer)
    setMatrixUniforms
    gl.drawElements(GlEnum.triangles, cubeVertexIndices.size, GlEnum.unsignedShort, 0)

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

      xRot += (90 * elapsed) / 1000.0f
      yRot += (90 * elapsed) / 1000.0f
      zRot += (90 * elapsed) / 1000.0f
    }
    lastTime = timeNow;
  }

  private Void initShader()
  {
    fStr := Str<|
                  #ifdef GL_ES
                  precision highp float;
                  #endif

                  varying vec2 vTextureCoord;
                  uniform sampler2D uSampler;

                  void main(void) {
                    gl_FragColor = texture2D(uSampler, vec2(vTextureCoord.s, vTextureCoord.t));
                  }
                 |>

    vStr := Str<|   attribute vec3 aVertexPosition;
                    attribute vec2 aTextureCoord;

                    uniform mat4 uMVMatrix;
                    uniform mat4 uPMatrix;

                    varying vec2 vTextureCoord;

                    void main(void) {
                      gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
                      vTextureCoord = aTextureCoord;
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

    textureCoordAttribute = gl.getAttribLocation(shaderProgram, "aTextureCoord")
    gl.enableVertexAttribArray(textureCoordAttribute)

    pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix")
    mvMatrixUniform = gl.getUniformLocation(shaderProgram, "uMVMatrix")
    samplerUniform = gl.getUniformLocation(shaderProgram, "uSampler")
  }

  private Void initBuffer()
  {
    //square
    cubeVertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexPositionBuffer)
    vertices := [
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


    cubeVertexTextureCoordBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, cubeVertexTextureCoordBuffer)
    textureCoords := [
      // Front face
      0.0f, 0.0f,
      1.0f, 0.0f,
      1.0f, 1.0f,
      0.0f, 1.0f,

      // Back face
      1.0f, 0.0f,
      1.0f, 1.0f,
      0.0f, 1.0f,
      0.0f, 0.0f,

      // Top face
      0.0f, 1.0f,
      0.0f, 0.0f,
      1.0f, 0.0f,
      1.0f, 1.0f,

      // Bottom face
      1.0f, 1.0f,
      0.0f, 1.0f,
      0.0f, 0.0f,
      1.0f, 0.0f,

      // Right face
      1.0f, 0.0f,
      1.0f, 1.0f,
      0.0f, 1.0f,
      0.0f, 0.0f,

      // Left face
      0.0f, 0.0f,
      1.0f, 0.0f,
      1.0f, 1.0f,
      0.0f, 1.0f,
    ]
    gl.bufferData(GlEnum.arrayBuffer, ArrayBuffer.makeFloat(textureCoords), GlEnum.staticDraw)


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

