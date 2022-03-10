//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2022-3-8  Jed Young  Creation
//

using vaseGui

@Js
class PercentTest : BasePage
{
  protected override Widget view() {
    Pane {
      layout.height = Layout.matchParent
      VBox {
        layout = Layout {
            width = 30
            wUnit = "%"
            height = Layout.matchParent

            //vAlign = Align.center
            hAlign = Align.center
        }

        spacing = 20
        align = Align.center
        
        Button {
          layout = Layout {
            height = 100
            width = 100
            hUnit = "%w"
            wUnit = "%"
          }
        },
        Button {
          layout = Layout {
            height = 100
            width = 100
            hUnit = "%w"
            wUnit = "%"
          }
        },
        Button {
          layout = Layout {
            height = 100
            width = 100
            hUnit = "%w"
            wUnit = "%"
          }
        },

      },
    }
  }
}