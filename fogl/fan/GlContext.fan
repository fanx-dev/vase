//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


class GlContext
{

//////////////////////////////////////////////////////////////////////////
// Const
//////////////////////////////////////////////////////////////////////////

  private GlEnumFactory enums := GlEnumFactory(this)

  const GlEnum glFragmentShader := enums.fragmentShader
  const GlEnum glCompileStatus := enums.compileStatus
  const GlEnum glVertexShader := enums.vertexShader
  const GlEnum glLinkStatus := enums.linkStatus

  const GlEnum glDeepTest := enums.deepTest
  const GlEnum glStaticDraw := enums.staticDraw
  const GlEnum glColorBufferBit := enums.colorBufferBit
  const GlEnum glDeepBufferBit := enums.deepBufferBit

  const GlEnum glArrayBuffer := enums.arrayBuffer
  const GlEnum glFloat := enums.float


//////////////////////////////////////////////////////////////////////////
// Common
//////////////////////////////////////////////////////////////////////////

  native Void clearColor(Int a, Int r, Int g, Int b)

  native Void enable(GlEnum e)

  native Void viewport(Int x, Int y, Int width, Int height)

  native Void clear(GlEnum e)

  native Void vertexAttribPointer(Int indx, Int size, GlEnum type, Bool normalized, Int stride, Int offset)

  native Void drawArrays(GlEnum mode, Int first, Int count)

//////////////////////////////////////////////////////////////////////////
// Buffer
//////////////////////////////////////////////////////////////////////////

  native Buffer createBuffer()
  native Void bindBuffer(GlEnum e, Buffer buf)
  native Void bufferData(GlEnum e, Float32Array array, GlEnum e)


//////////////////////////////////////////////////////////////////////////
// Shader
//////////////////////////////////////////////////////////////////////////

  native Shader createShader()
  native Void shaderSource(Str source)
  native Void compileShader(Shader s)
  native Int getShaderParameter(Shader s, GlEnum e)
  native Str getShaderInfoLog(Shader s)

  native Program createProgram()
  native Void attachShader(Program p, Shader s)
  native Void linkProgram(Shader s)
  native Int getProgramParameter(Program p, GlEnum s)
  native Void useProgram(Program p)

  native Int getAttribLocation(Program p, Str name)
  native Void enableVertexAttribArray(Int index)

  native UniformLocation getUniformLocation(Program program, Str name)
  native Void uniformMatrix4fv(UniformLocation location, Bool transpose, Float32Array value)
}