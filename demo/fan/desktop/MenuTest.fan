//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

@Js
class MenuTest : BasePage
{
  protected override Widget view() {
    Menu
    {
      MenuItem
      {
        text = "File"
        MenuItem
        {
          text = "Open"
          MenuItem{text = "From 1"},
          MenuItem{text = "From 2"},
        },
        MenuItem
        {
          text = "Save"
          MenuItem{text = "as 1"},
          MenuItem{text = "as 2"},
        },
      },
      MenuItem
      {
        text = "Edit"
        MenuItem{text = "Copy"},
        MenuItem{text = "Paste"},
      },
      MenuItem
      {
        text = "Help"
        MenuItem
        {
          text = "About"
          onClick
          {
            Toast("hello world").show(frame)
          }
        },
      },
    }
  }
}