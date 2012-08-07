//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** MessageBox
**
@Js
class MessageBox : WidgetGroup
{
  Label label { private set }

  new make()
  {
    label = Label { it.id = "messageBox_msg"; it.text = "messageBox" }
    this.add(label)
    btn := Button { it.id = "messageBox_ok"; onAction.add { echo("Hi") }; it.text = "OK" }
    this.add(btn)

    this.layout = VBox()
  }
}