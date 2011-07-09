//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

@Js
class GlContext
{

//////////////////////////////////////////////////////////////////////////
// Common
//////////////////////////////////////////////////////////////////////////

  native Void clearColor(Float red, Float green, Float blue, Float alpha)

  native Void enable(GlEnum cap)

  native Void viewport(Int x, Int y, Int width, Int height)

  native Void clear(GlEnum mask)

  native Void vertexAttribPointer(Int indx, Int size, GlEnum type, Bool normalized, Int stride, Int offset)

  native Void drawArrays(GlEnum mode, Int first, Int count)

//////////////////////////////////////////////////////////////////////////
// Buffer
//////////////////////////////////////////////////////////////////////////

  native Buffer createBuffer()
  native Void bindBuffer(GlEnum target, Buffer buffer)
  native Void bufferData(GlEnum target, ArrayBuffer data, GlEnum usage)


//////////////////////////////////////////////////////////////////////////
// Shader
//////////////////////////////////////////////////////////////////////////

  native Shader createShader(GlEnum type)
  native Void shaderSource(Shader shader, Str source)
  native Void compileShader(Shader shader)
  native Bool getShaderParameter(Shader shader, GlEnum pname)
  native Str getShaderInfoLog(Shader shader)

  native Program createProgram()
  native Void attachShader(Program program, Shader shader)
  native Void linkProgram(Program program)
  native Bool getProgramParameter(Program program, GlEnum pname)
  native Void validateProgram(Program program);
  native Void useProgram(Program program)

//////////////////////////////////////////////////////////////////////////
// Uniform
//////////////////////////////////////////////////////////////////////////

  native UniformLocation getUniformLocation(Program program, Str name)
  native Void uniformMatrix4fv(UniformLocation location, Bool transpose, ArrayBuffer value)

//////////////////////////////////////////////////////////////////////////
// VertexShader
//////////////////////////////////////////////////////////////////////////

  native Int getAttribLocation(Program program, Str name)
  native Void enableVertexAttribArray(Int index)
}