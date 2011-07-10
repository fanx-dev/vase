//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

@Js
mixin GlContext
{

//////////////////////////////////////////////////////////////////////////
// Common
//////////////////////////////////////////////////////////////////////////

  abstract Void clearColor(Float red, Float green, Float blue, Float alpha)

  abstract Void enable(GlEnum cap)

  abstract Void viewport(Int x, Int y, Int width, Int height)

  abstract Void clear(GlEnum mask)

  abstract Void vertexAttribPointer(Int indx, Int size, GlEnum type, Bool normalized, Int stride, Int offset)

  abstract Void drawArrays(GlEnum mode, Int first, Int count)

//////////////////////////////////////////////////////////////////////////
// Buffer
//////////////////////////////////////////////////////////////////////////

  abstract Buffer createBuffer()
  abstract Void bindBuffer(GlEnum target, Buffer buffer)
  abstract Void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)


//////////////////////////////////////////////////////////////////////////
// Shader
//////////////////////////////////////////////////////////////////////////

  abstract Shader createShader(GlEnum type)
  abstract Void shaderSource(Shader shader, Str source)
  abstract Void compileShader(Shader shader)
  abstract Bool getShaderParameter(Shader shader, GlEnum pname)
  abstract Str getShaderInfoLog(Shader shader)

  abstract Program createProgram()
  abstract Void attachShader(Program program, Shader shader)
  abstract Void linkProgram(Program program)
  abstract Bool getProgramParameter(Program program, GlEnum pname)
  abstract Void validateProgram(Program program);
  abstract Void useProgram(Program program)

//////////////////////////////////////////////////////////////////////////
// Uniform
//////////////////////////////////////////////////////////////////////////

  abstract UniformLocation getUniformLocation(Program program, Str name)
  abstract Void uniformMatrix4fv(UniformLocation location, Bool transpose, ArrayBuffer value)

//////////////////////////////////////////////////////////////////////////
// VertexShader
//////////////////////////////////////////////////////////////////////////

  abstract Int getAttribLocation(Program program, Str name)
  abstract Void enableVertexAttribArray(Int index)
}