//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using vaseGui

@Js
class HBoxTest : BasePage
{
  protected override Widget view() {
    VBox {
      HBox
      {
        Button { text = "btn1" },
        Button { text = "btn2"; layout.weight = 3.0f },
        Button { text = "btn3" },
      },
      HBox
      {
        align = Align.center
        it.spacing = 20
        Button { text = "btn1"; layout.width = Layout.wrapContent },
        Button { text = "btn2"; layout.width = Layout.wrapContent },
        Button { text = "btn3"; layout.width = Layout.wrapContent },
      }
    }
  }
}