//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using fogl

class Display : GlDisplay
{
  Void main()
  {
    Display().open
  }

  override Void init(GlContext gl)
  {
    gl.clearColor(1f, 1f, 0f, 1f);
    gl.enable(GlEnum.glDepthTest);
  }

  override Void onPaint(GlContext gl)
  {
    gl.clear(GlEnum.glColorBufferBit.mix(GlEnum.glDepthBufferBit))
    //gl.loadIdentity()
  }
}

