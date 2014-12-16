//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** ComboBox
**
@Js
class ComboBox : ButtonBase
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
    padding = Insets(dpToPixel(10))
    this.layoutParam.width = font.height * 10
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

    pane := LinearLayout()
    list = pane

    items.each |item, i|
    {
      name := item.toStr
      Button? button
      button = Button { 
        it.text = name; 
        it.styleClass = "menuItem";
        it.layoutParam.width = it.font.height * 10
        it.onAction.add { select(button, i) } 
      }
      pane.add(button)
    }

    root := this.getRootView
    root.add(pane)
    root.requestLayout

    pos := Coord(0, 0)
    rc := posOnWindow(pos)
    pane.layoutParam.width = LayoutParam.wrapContent
    pane.layoutParam.posX = pos.x
    pane.layoutParam.posY = pos.y + height
    pane.focus
    root.requestPaint
    
    pane.onFocusChanged.add |e| { 
      if (e.data == false) {
        hide
      }
    }
  }

  Void hide()
  {
    if (list == null) return
    WidgetGroup p := list.parent
    p.remove(list)
    p.requestPaint
    if (this.hasFocus) {
      (p as RootView).focusIt(null)
    }
    list = null
  }
}