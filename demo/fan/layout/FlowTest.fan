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
class FlowTest : BasePage
{
  protected override Widget view() {
    FlowBox
    {
      margin = Insets(50)
      p := it
      10.times |i|{
        p.add(Button{
          text = "$i"
          layout.width = 100
        })
      }
    }
  }
}
