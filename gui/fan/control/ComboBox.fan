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
  
  private CtxMenu? list

  new make()
  {
    text = ""
    this.onAction.add { show }
    padding = Insets(15)
  }

  Void show()
  {
    if (list == null)
    {
      list = CtxMenu {
        it.layout.vAlign = Align.begin
        it.layout.hAlign = Align.begin
        it.layout.width = it.pixelToDp(this.width)
        it.layout.height = 600
        it.items = this.items
        it.onAction |i| {
          selIndex = i
        }
      }
    }
    
    if (list.parent != null) {
        list.hide
        return
    }

    pos := Coord(0f, 0f)
    rc := posOnWindow(pos)
    list.layout.offsetX = pixelToDp(pos.x.toInt)
    list.layout.offsetY = pixelToDp(pos.y.toInt + height)
    //echo("${list.layout.offsetY},${pos.y.toInt},${height}")
    list.show(this)
  }
}

@Js
class CtxMenu : ScrollPane {
    Obj[] items := [,]
    
    private Bool inited := false
    private |Int|? clickCallback
    
    Void onAction(|Int| f) { clickCallback = f }
    
    new make() {
      layout.width = 400
      layout.height = 600
      layout.vAlign = Align.center
      layout.hAlign = Align.center
      
      this.focusable = true
      
      onFocusChanged.add |e| {
        //echo("onFocusChanged: $e.data")
        if (e.data == false) {
          hide
        }
      }
    }
    
    private Void init() {
        if (inited) return
        inited = true
        
        pane := VBox { spacing = 0 }
        items.each |item, i|
        {
          name := item.toStr
          button := Button {
            it.text = name;
            it.style = "menuItem"
            it.textAlign = Align.begin
            it.layout.width = Layout.matchParent
            //it.layout.widthVal = it.pixelToDp()
            it.padding = Insets(15)
            //it.margin = Insets(2, 0, 0)
            it.onClick {
              this.hide
              clickCallback?.call(i)
            }
            it.rippleEnable = false
          }
          pane.add(button)
        }
        this.add(pane)
    }
    
    Void show(Widget w) {
        init
        root := w.getRootView
        overlayer := root.topOverlayer
        overlayer.add(this)
        this.relayout
        overlayer.relayout
        this.focus
        root.setModal(1, this)
    }
    
    Void hide()
    {
      if (this.parent == null) return
      
      root := this.getRootView
      root.clearFocus
      root.setModal(0, this)
      
      WidgetGroup p := this.parent
      p.remove(this)
    }
}