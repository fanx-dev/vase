//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using fanvasGui

@Js
class ProgressViewTest : BaseTestWin
{
  protected override Widget build() {
    LinearLayout
    {
      it.id = "mainView"
      it.margin = Insets(100)
      ProgressView {
        it.id = "ProgressView"
      },
    }
  }
}