//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using vaseGraphics
using concurrent

**
** native host view
**
@Js
mixin Window
{
  abstract View view()
  
  **
  ** request repaint
  **
  abstract Void repaint(Rect? dirty := null)

  **
  ** get current position
  **
  abstract Point pos()

  ** get window size
  abstract Size size()

  **
  ** return true if has focus
  **
  abstract Bool hasFocus()

  **
  ** request focus
  **
  abstract Void focus()

  **
  ** show text edit view
  **
  abstract Void textInput(TextInput edit)


  abstract Void fileDialog(Str accept, |Obj[]?| f, [Str:Obj]? options := null)
}

internal class NWindow : Window {
  native override View view()
  native override Void repaint(Rect? dirty := null)
  native override Point pos()
  native override Size size()
  native override Bool hasFocus()
  native override Void focus()
  native override Void textInput(TextInput edit)
  native override Void fileDialog(Str accept, |Obj[]?| f, [Str:Obj]? options := null)
}
