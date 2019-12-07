//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using vaseGui

@Js
class ListViewTest : BaseTestWin
{
  protected override Widget build() {
    Str[] list := [,]
    100.times { list.add("item$it") }

    return  ListView {
      model = SimpleListAdapter(list)
    }
  }
}