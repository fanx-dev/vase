//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfx2d
using concurrent

**
** root view
**
@Js
mixin View
{
  virtual Void onPaint(Graphics g) {}

  virtual Void onEvent(InputEvent e) {}

  virtual Void onDisplayEvent(DisplayEvent e) {}
}

**
** Window
**
@Js
mixin Window
{
  abstract Void repaint(Rect? dirty := null)

  abstract Size size()
  abstract Point pos()

  abstract Void show(Size? size := null)

  abstract Bool hasFocus()
  abstract Void focus()

  static new make(View view) { Toolkit.cur.build(view) }
}

