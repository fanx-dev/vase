//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using gfx2
using gfx

class Button : Widget
{
  Int arc := 30
  Str text := ""
  Brush bg := Color.gray
  
  once EventListeners onAction() { EventListeners() }
  
  override Void touch(MotionEvent e)
  {
    if (e.isUp)
    {
      bg = Color.gray
      if (this.view.gesture.isClick)
      {
        onAction.fire(e)
      }
    }
    else if (e.isDown)
    {
      bg = Color.yellow
    }
    this.repaint
  }
  
  override Void keyPress(KeyEvent e)
  {
    if (!e.isDown && e.keyCode == '\n')
    {
      onAction.fire(e)
    }
  }
  
  override Void paint(Graphics2 g)
  {
    g.brush = bg
    g.fillRoundRect(0, 0, size.w, size.h, arc, arc)
    g.brush = Color.red
    g.drawText(text, size.w/2 -10, size.h/2 -10)
  }
}
