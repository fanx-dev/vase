//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

@Js
class PaneTest : BasePage
{
  protected override Widget view() {
    Pane
    {
      padding = Insets(50)
      margin = Insets(50)
      style = "shadow"
      layout.height = Layout.matchParent
      Button
      {
        text = "btn1"
        layout.offsetX = 20
        layout.offsetY = 30
        layout.width = Layout.wrapContent
      },
      Button
      {
        text = "btn2"
        layout.vAlign = Align.center
        layout.hAlign = Align.center
        layout.width = Layout.wrapContent
      },
      Button
      {
        text = "btn3"
        layout.width = Layout.wrapContent
        layout.hAlign = Align.end
        layout.vAlign = Align.end
        layout.offsetX = -20
        layout.offsetY = -30
      },
    }
  }
}