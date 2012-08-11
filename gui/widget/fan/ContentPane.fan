//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** ContentPane is the base class for panes which only
** contain one child widget called 'content'.
**
@Js
class ContentPane : WidgetGroup
{
  new make()
  {
    layout = InsetLayout()
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
    if (&content == null) &content=child
    super.add(child)
    return this
  }

  **
  ** Internal hook to call Widget.add version directly and skip
  ** hook to implicitly mount any added child as content.
  **
  Void doAdd(Widget? child) { super.add(child) }

}