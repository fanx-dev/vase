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
class MessageBox : ContentPane
{
  Label label { private set }

  new make()
  {
    label = Label { it.id = "messageBox_msg"; it.text = "messageBox" }
    btn := Button { it.id = "messageBox_ok"; onAction.add { hide }; it.text = "OK" }

    pane := WidgetGroup()
    pane.add(label)
    pane.add(btn)
    pane.layout = VBox()

    this.add(pane)
  }

  Void show(Widget w)
  {
    root := w.rootView
    root.add(this)
    this.relayout
    this.pos = Point(root.size.w/2 - this.size.w/2, root.size.h/2 - this.size.h/2)
    root.relayout
    this.focus
    root.modal = true
    root.repaint
  }

  Void hide()
  {
    WidgetGroup p := parent
    p.remove(this)
    p.relayout
    p.repaint
    (p as RootView).modal = false
    (p as RootView).focusWidget = null
  }
}