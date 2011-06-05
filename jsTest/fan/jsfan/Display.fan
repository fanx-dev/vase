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
    gl.clearColor(1f, 1f, 0f, 1f);
    gl.enable(GlEnum.depthTest);
  }

  override Void onPaint(GlContext gl)
  {
    gl.clear(GlEnum.colorBufferBit.mix(GlEnum.depthBufferBit))
    //gl.loadIdentity()
  }
}

