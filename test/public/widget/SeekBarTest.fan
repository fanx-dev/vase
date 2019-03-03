//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using fanvasGui

@Js
class SeekBarTest : BaseTestWin
{
  protected override Widget build() {
    LinearLayout
    {
      it.id = "mainView"
      it.margin = Insets(100)
      SliderBar {
        it.id = "seekBar"
        it.setCurPos(10f, false)
      },
    }
  }
}