//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using vaseGui
using vaseWindow
using vaseGraphics

**
** Win Test
**
@Js
class ButtonTest : BasePage
{
  protected override Widget view() {
    VBox
    {
      padding = Insets(50)
      layout.height = Layout.matchParent
      spacing = 15
      Button {
        text = "Flat Button"
        style = "flatButton"
        onClick { Toast("hello world").show(it) }
      },
      Button {
        text = "Push Button";
        onClick { Toast("${Toolkit.cur.density}").show(it) }
      },
      Button {
        text = "Disable Button";
        enabled = false
        onClick { Toast("hello world").show(it) }
      },

      ToggleButton { text = "switch" },
      ToggleButton { text = "checkBox"; style = "checkBox" },
      RadioButton { text = "radio1" },
      RadioButton { text = "radio2" },

    }
  }
}