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

  virtual Void onMotionEvent(MotionEvent e) {}

  virtual Void onKeyEvent(KeyEvent e) {}

  virtual Void onDisplayEvent(DisplayEvent e) {}

  abstract NativeView? nativeView

  abstract Size size()
}

@Js
mixin NativeView
{
  abstract Void repaint(Rect? dirty := null)

  abstract Size size()
  abstract Point pos()

  abstract Bool hasFocus()
  abstract Void focus()
}

**
** Window is a host display
**
@Js
mixin Window
{
  abstract This add(View view)
  abstract Void show(Size? size := null)
}

