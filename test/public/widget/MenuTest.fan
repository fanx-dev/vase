//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

@Js
class MenuTest : BaseTestWin
{
  protected override Widget build() {
    Menu
    {
      MenuItem
      {
        it.text = "File"
        MenuItem
        {
          it.text = "Open"
          MenuItem{it.text = "From 1"},
          MenuItem{it.text = "From 2"},
        },
        MenuItem
        {
          it.text = "Save"
          MenuItem{it.text = "as 1"},
          MenuItem{it.text = "as 2"},
        },
      },
      MenuItem
      {
        it.text = "Edit"
        MenuItem{it.text = "Copy"},
        MenuItem{it.text = "Paste"},
      },
      MenuItem
      {
        it.text = "Help"
        MenuItem
        {
          it.text = "About"
          it.onAction.add
          {
            Toast { it.text = "hello world" }.show(root)
          }
        },
      },
    }
  }

  protected override Void init(Frame view) {
    //view.layout.widthType = SizeType.fixed
    //view.layout.heightType = SizeType.fixed
    view.layout.width = view.pixelToDp(600)
    view.layout.height = view.pixelToDp(600)
  }

  override Void main() { super.main }
}