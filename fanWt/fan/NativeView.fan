//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fan2d
using concurrent

**
** root view
**
@Js
mixin View
{
  virtual Void onPaint(Graphics g) {}

  virtual Void onEvent(InputEvent e) {}
}

**
** Window
**
@Js
mixin Window
{
  abstract Void repaint(Rect? dirty := null)
  abstract Void repaintLater(Rect? dirty := null)

  abstract Size size()
  abstract Point pos()

  abstract Void show(Size? size := null)

  abstract Bool hasFocus()
  abstract Void focus()

  static Window build(View view)
  {
    NativeToolkit.cur.build(view)
  }
}

@NoDoc
@Js
mixin NativeToolkit
{
  static NativeToolkit cur()
  {
    NativeToolkit? factory := Actor.locals["fanWt.NativeToolkit"]
    if (factory == null) throw NullErr("No NativeToolkit is active")
    return factory
  }
  abstract Window build(View view)
}