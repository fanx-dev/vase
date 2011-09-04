//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using fwt
using gfx2
using gfx

using concurrent

**
** Canvas2 to suppert gfx2
**
@Js
@Serializable
class Canvas2 : Canvas
{
  ** init the GfxEnv
  private static const FwtEnv2 env2 := FwtEnv2.make()

  new make()
  {
    Actor.locals["gfx.env2"] = env2
  }

  **
  ** This callback is invoked when the widget should be repainted.
  ** The graphics context is initialized at the widget's origin
  ** with the clip bounds set to the widget's size.
  **
  virtual Void onPaint2(Graphics2 g) {}

  // to force native peer
  private native Void dummyCanvas()

  native Void setCaret(Int x, Int y, Int w, Int h)

  **
  ** hint double buffered
  **
  Bool buffered := false

}