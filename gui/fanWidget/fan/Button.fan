//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanWt
using fan2d

class Button : Widget
{
  Int arc := 20
  Str text := ""
  Brush bg := Color.green

  once EventListeners onAction() { EventListeners() }

  override Void touch(InputEvent e)
  {
    if (e.type == InputEventType.release)
    {
      bg = Color.green
      //if (this.view.gesture.isClick)
      //{
        onAction.fire(e)
      //}
    }
    else if (e.type == InputEventType.press)
    {
      bg = Color.gray
    }
    else if (e.type == InputEventType.move)
    {
      bg = Color.yellow
    }
    this.repaint
  }

  override Void keyPress(InputEvent e)
  {
    if (e.type == InputEventType.release && e.key == Key.enter)
    {
      onAction.fire(e)
    }
  }

  override Void onPaint(Graphics g)
  {
    g.brush = bg
    //g.fillRoundRect(1, 1, size.w-1, size.h-1, arc, arc)
    g.fillRect(0, 0, size.w, size.h)
    g.brush = Color.red
    g.drawText(text, (arc/2.0f).toInt, (arc/2.0f).toInt + 10)
  }
}