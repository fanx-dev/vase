//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using gfx
using gfx2
using gfx2Imp
using fwt

class FwtView : NativeView
{
  FwtCanvas canvas
  View view
  
  override Size size() { canvas.size }
  override Point pos() { canvas.pos }
  
  override Void repaint(Rect? dirty := null) { canvas.repaint(dirty) }
  
  override Void show(Size? size := null)
  {
    Window
    {
      content = canvas
      if (size != null)
      {
        it.size = size
      }
    }.open
  }
  
  new make(View view)
  {
    this.view = view
    this.canvas = FwtCanvas(view)
  }
}

class FwtCanvas : Canvas2
{
  View view
  
  new make(View view)
  {
    this.view = view
  }
  
  override Void onPaint(Graphics g)
  {
    view.paint(g)
  }
}

class FwtViewFactory : NativeViewFactory
{
  override NativeView build(View view)
  {
    return FwtView(view)
  }
}