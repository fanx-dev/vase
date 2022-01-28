//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

class ScrollCardTest : BasePage
{
  protected override Widget view() {
    VBox {
      layout.height = Layout.matchParent
      Pane {
        layout.height = Layout.matchParent
        RectView { layout.height = 200 },
        ScrollCard
        {
          padding = Insets(50, 0, 0, 0)
          maxOffset = 0.5
          offsetY = 0.0
          layout.height = Layout.matchParent

          ScrollPane {
            VBox {
              vbox := it
              40.times |i|{
                vbox.add(Button{
                  text = "$i"
                })
              }
            },
          },
        },
      },
      RectView { layout.height = 200 },
    }
  }
}
