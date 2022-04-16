//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using vaseGraphics
using vaseWindow


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
      this.detach
    }
}