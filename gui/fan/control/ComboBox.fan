//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

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
    padding = Insets(dpToPixel(10f))
  }

  private Void select(ButtonBase btn, Int i)
  {
    selectedIndex = i
    this.requestPaint
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
      ButtonBase? button
      button = ButtonBase {
        it.text = name;
        it.styleClass = "menuItem";
        it.layoutParam.width = it.font.height * 10
        it.onAction.add { select(button, i) }
      }
      pane.add(button)
    }

    root := this.getRootView
    overlayer := root.topOverlayer
    overlayer.add(pane)

    pos := Coord(0, 0)
    rc := posOnWindow(pos)
    pane.layoutParam.width = LayoutParam.wrapContent
    pane.layoutParam.posX = pos.x
    pane.layoutParam.posY = pos.y + height
    pane.focus

    pane.onFocusChanged.add |e| {
      if (e.data == false) {
        hide
      }
    }

    overlayer.requestLayout
    root.modal = true
  }

  Void hide()
  {
    if (list == null || list.parent == null) return
    WidgetGroup p := list.parent
    p.remove(list)
    root := this.getRootView
    root.focusIt(null)
    root.modal = false
    p.requestPaint
    list = null
  }
}