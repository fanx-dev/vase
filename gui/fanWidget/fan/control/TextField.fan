//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanWt
using fan2d

class TextField : Widget
{
  Str text := ""

  new make()
  {
    size = Size(100, 20)
  }

  override Void keyPress(InputEvent e)
  {
    if (e.key == Key.backspace)
    {
      if (text.size > 0)
      {
        text = text[0..-2]
        repaint
        return
      }
    }

    if (e.id != InputEvent.keyTyped) return

    text += e.keyChar.toChar
    repaint
  }

  override Void touch(InputEvent e)
  {
    if (this.bounds.contains(e.x, e.y))
    {
      if (e.type == InputEventType.press)
      {
        focus
      }
    }
  }
}