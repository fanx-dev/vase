//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using fgfxMath

@Js
mixin Effect
{
  abstract Graphics prepare(Widget widget, Graphics g)

  abstract Void end(|Graphics| paint)
}

