//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** ComboBox
**
@Js
class ComboBox : ButtonBase
{
  Obj[] items := [,]
  Int selIndex := -1
  {
    set
    {
      val := it
      if (&selIndex == val) return
      e := StateChangedEvent (&selIndex, val, #selIndex, this )
      onStateChanged.fire(e)
      &selIndex = val
      this.text = items[val].toStr
    }
  }

  private WidgetGroup? list

  new make()
  {
    text = "v"
    this.onAction.add { show }
    padding = Insets(10)
  }

  private Void select(ButtonBase btn, Int i)
  {
    selIndex = i
    this.repaint
    hide
  }

  Void show()
  {
    if (list != null)
    {
      hide
      return
    }

    pane := VBox()
    list = pane

    items.each |item, i|
    {
      name := item.toStr
      ButtonBase? button
      button = ButtonBase {
        it.text = name;
        it.style = "menuItem";
        it.layout.width = Layout.matchParent
        //it.layout.widthVal = it.pixelToDp()
        it.padding = Insets(10, 0)
        it.onAction.add { select(button, i) }
      }
      pane.add(button)
    }

    root := this.getRootView
    overlayer := root.topOverlayer
    overlayer.add(pane)

    pos := Coord(0, 0)
    rc := posOnWindow(pos)
    pane.spacing = 0f
    //pane.layout.widthType = SizeType.fixed
    pane.layout.width = pixelToDp(this.width)
    pane.layout.offsetX = pixelToDp(pos.x)
    pane.layout.offsetY = pixelToDp(pos.y + height)
    pane.focus

    pane.onFocusChanged.add |e| {
      if (e.data == false) {
        hide
      }
    }

    overlayer.relayout
    root.modal = 1
  }

  Void hide()
  {
    if (list == null || list.parent == null) return
    WidgetGroup p := list.parent
    p.remove(list)
    root := this.getRootView
    root.focusIt(null)
    root.modal = 0
    p.repaint
    list = null
  }
}