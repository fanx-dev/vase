//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui
using vaseWindow

@Js
class EditTextTest : BasePage
{
  protected override Widget view() {
    VBox {
      margin = Insets(10)
      layout.height = Layout.matchParent
      
      EditText {
        hint = "EditText"
      },
      EditText {
        inputType = TextInput.inputTypePassword
        hint = "Password"
      },
      EditText {
        inputType = TextInput.inputTypeMultiLine
        hint = "MultiLine"
        layout.height = Layout.matchParent
      },
      EditText {
        hint = "EditText"
        layout.vAlign = Align.end
      },
    }
  }
}