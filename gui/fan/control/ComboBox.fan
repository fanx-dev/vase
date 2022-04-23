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
class ComboBox : Button
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

  new make()
  {
    text = ""
    this.onAction.add { show }
    padding = Insets(15)
  }

  Void show()
  {

    list := CtxMenu {
      it.layout.vAlign = Align.begin
      it.layout.hAlign = Align.begin
      it.layout.width = it.pixelToDp(this.width)
      it.layout.height = 600
      it.items = this.items
      it.onAction |i| {
        selIndex = i
      }
    }

    pos := posOnWindow
    list.layout.offsetX = pixelToDp(pos.x.toInt)
    list.layout.offsetY = pixelToDp(pos.y.toInt + height)
    //echo("${list.layout.offsetY},${pos.y.toInt},${height}")
    list.show(this)
  }
}
