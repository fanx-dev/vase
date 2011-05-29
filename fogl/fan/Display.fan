//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


class Display
{
  native Void create()

  native Void repaint()

  virtual Void onPaint(GlContext gl) {}
}