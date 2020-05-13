//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using vaseGui

@Js
class ListViewTest : BasePage
{
  protected override Widget view() {
    Str[] list := [,]
    100.times { list.add("item$it") }

    return ListView {
      model = SimpleListAdapter(list)
      refreshTip = ProgressView {
        layout.hAlign = Align.center
        layout.height = 60.0
        layout.width = 60.0
      }
    }
  }
}