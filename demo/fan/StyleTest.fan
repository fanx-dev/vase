//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-10-10  Jed Young  Creation
//

using vaseGui
using vaseWindow
using vaseGraphics

@Js
class StyleTest : BasePage
{
  Button? button

  protected override Void init(Frame frame) {
    styleFile := `/res/testStyle.fog`
    [Str:Obj] style = Toolkit.cur.loadResFile("vaseDemo", styleFile).toStr.in.readObj
    //root.styleManager = StyleManager()
    frame.styleManager.styleClassMap.setAll(style)
  }

  protected override Widget view() {
    viewFile := `/res/testView.fog`
    Widget view = Toolkit.cur.loadResFile("vaseDemo", viewFile).toStr.in.readObj

    Binding.inject(view, this)
    button.onClick {
      Toast("hello world").show(it)
    }
    return view
  }
}
