//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

const class GlEnum
{
  internal new make(){}

  native GlEnum mix(GlEnum e)
  native Int val()
}

**************************************************************************
**************************************************************************

internal class GlEnumFactory
{
  GlContext gl

  new make(GlContext gl) { this.gl = gl }



  native GlEnum fragmentShader()//FRAGMENT_SHADER
  native GlEnum compileStatus()//COMPILE_STATUS
  native GlEnum vertexShader()//VERTEX_SHADER
  native GlEnum linkStatus()//LINK_STATUS

  native GlEnum deepTest()//DEPTH_TEST
  native GlEnum staticDraw()//STATIC_DRAW
  native GlEnum colorBufferBit()//COLOR_BUFFER_BIT
  native GlEnum deepBufferBit()//DEPTH_BUFFER_BIT

  native GlEnum arrayBuffer()//ARRAY_BUFFER
  native GlEnum float()//FLOAT
}