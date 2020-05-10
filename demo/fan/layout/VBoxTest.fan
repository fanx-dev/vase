//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

**
** VBox
**
class VBoxTest : BasePage
{
  protected override Widget view() {
    VBox
    {
      margin = Insets(50)
      Button
      {
        text = "btn1"
        layout.offsetX = 800f
        layout.offsetY = 500f
        layout.width = Layout.wrapContent
      },
      Button
      {
        text = "btn2"
        layout.height = Layout.matchParent
        layout.width = 600f
      },
      Button
      {
        text = "btn3"
        layout.width = Layout.matchParent
      },

    }
  }
}
