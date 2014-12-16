//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fgfxOpenGl

@Js
class Program
{
  private GlShader? vertexShader
  private GlShader? fragmentShader

  private Shader vertexShaderSrc
  private Shader fragmentShaderSrc

  private GlProgram? shaderProgram

  private GlContext? gl

  new make(Shader vertexShaderSrc, Shader fragmentShaderSrc)
  {
    this.vertexShaderSrc = vertexShaderSrc
    this.fragmentShaderSrc = fragmentShaderSrc
  }

//////////////////////////////////////////////////////////////////////////
// Init
//////////////////////////////////////////////////////////////////////////

  Void init(GlContext gl)
  {
    this.gl = gl
    fragmentShader = getShader(GlEnum.fragmentShader, fragmentShaderSrc.src)
    vertexShader = getShader(GlEnum.vertexShader, vertexShaderSrc.src)

    shaderProgram = gl.createProgram
    gl.attachShader(shaderProgram, vertexShader)
    gl.attachShader(shaderProgram, fragmentShader)
    gl.linkProgram(shaderProgram)
    gl.validateProgram(shaderProgram)

    if (gl.getProgramParameter(shaderProgram, GlEnum.linkStatus) == 0) {
        throw Err("Could not initialise shaders")
    }
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

//////////////////////////////////////////////////////////////////////////
// Using
//////////////////////////////////////////////////////////////////////////

  Void useProgram() { gl.useProgram(shaderProgram) }

  Int getAttribLocation(Str name) { gl.getAttribLocation(shaderProgram, name) }

  GlUniformLocation getUniformLocation(Str name) { gl.getUniformLocation(shaderProgram, name) }
}