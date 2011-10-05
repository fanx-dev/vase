//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using gfx
using gfx2

@Js
abstract class Widget
{
  Bool visible := true
  Bool enabled := true
  
  Point pos := Point(0, 0)
  Size size := Size.defVal
  
  Widget[] children := Widget[,]
  
  virtual This relayout() { return this }
  virtual Size prefSize(Hints hints := Hints.defVal) { return size }
  virtual Void repaint(Rect? dirty := null) {}
  
  virtual Void touch(MotionEvent e) {}
  virtual Void paint(Graphics2 g) {}
}
