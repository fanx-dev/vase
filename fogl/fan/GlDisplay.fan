//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

@Js
class GlDisplay
{
  Int w := 800
  Int h := 600

  native Void open()

  native Void repaint()

  virtual Void init(GlContext gl) {}
  virtual Void onPaint(GlContext gl) {}
}