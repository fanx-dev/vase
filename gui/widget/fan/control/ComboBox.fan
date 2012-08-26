//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** ComboBox
**
@Js
class ComboBox : Button
{
  Obj[] items := [,]
  Int selectedIndex := -1
  {
    set
    {
      val := it
      if (&selectedIndex == val) return
      e := StateChangedEvent (&selectedIndex, val, #selectedIndex, this )
      onStateChanged.fire(e)
      &selectedIndex = val
      this.text = items[val].toStr
    }
  }

  private WidgetGroup? list

  new make()
  {
    text = "v"
    this.onAction.add { show }
  }

  private Void select(Button btn, Int i)
  {
    selectedIndex = i
    hide
  }

  Void show()
  {
    if (list != null)
    {
      hide
      return
    }

    pane := WidgetGroup()
    list = pane
    pane.layout = VBoxLayout()

    items.each |item, i|
    {
      name := item.toStr
      Button? button
      button = Button { it.text = name; it.styleClass = "menuItem"; it.onAction.add { select(button, i) } }
      pane.add(button)
    }

    root := this.rootView
    root.add(pane)
    root.relayout

    pos := posOnWindow
    pane.pos = Point(pos.x, pos.y + size.h)
    pane.focus
    root.repaint
  }

  Void hide()
  {
    if (list == null) return
    WidgetGroup p := list.parent
    p.remove(list)
    p.repaint
    (p as RootView).focusWidget = null
    list = null
  }
}