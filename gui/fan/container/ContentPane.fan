//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** ContentPane is the base class for panes which only
** contain one child widget called 'content'.
**
@Js
class ContentPane : Pane
{
  new make()
  {
  }

  **
  ** The content child widget.
  **
  Widget? content { set { remove(&content); doAdd(it); &content = it } }

  **
  ** If this the first widget added, then assume it the content.
  **
  @Operator
  override This add(Widget child)
  {
    if (&content == null) content = child
    else throw UnsupportedErr("ContentPane only one child")
    return this
  }

  **
  ** Internal hook to call Widget.add version directly and skip
  ** hook to implicitly mount any added child as content.
  **
  internal Void doAdd(Widget? child) { super.add(child) }
}