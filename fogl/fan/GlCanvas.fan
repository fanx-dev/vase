//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using fwt

**
** GLCanvas is a widget capable of displaying OpenGL content.
**
@Js
class GlCanvas : Canvas
{
  virtual Void onGlPaint(GlContext gl) {}

  // to force native peer
  private native Void dummyCanvas()
}