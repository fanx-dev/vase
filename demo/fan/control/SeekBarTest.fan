//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using vaseGui

@Js
class SeekBarTest : BasePage
{
  protected override Widget view() {
    VBox
    {
      margin = Insets(100)
      label := Label { text = "Hello" }
      label,
      SliderBar {
        curPos = 10f
        onPosChanged {
          label.text = it.toStr
        }
      },
    }
  }
}