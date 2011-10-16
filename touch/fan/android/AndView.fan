//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using gfx
using gfx2
using gfx2Imp
using [java]android.view::View as AView
using [java]android.content::Context
using [java]android.graphics::Rect as ARect
using [java]android.app::Activity
using [java]android.graphics::Canvas
using [java]java.lang::Class
using [java]android.view::MotionEvent as AMotionEvent

class AndView : AView, NativeView
{
  View view

  new make(Context context, View view) : super(context)
  {
    this.view = view
  }

  override Size size() { Size.make(this.getWidth, this.getHeight) }
  override gfx::Point pos()
  {
    Int x := this.getLeft
    Int y := this.getTop
    return gfx::Point.make(x, y)
  }
  override Size displaySize() { throw Err("TODO") }

  override Void repaint(gfx::Rect? r := null)
  {
    if (r == null)
    {
      this.invalidate
      return
    }
    ARect rect := ARect(r.x, r.y, (r.x + r.w), (r.y + r.h))
    this.invalidate(rect)
  }
  override Bool hasFocus() { super.hasFocus }
  override Void focus() { this.requestFocus }

  override Void show(Size? size := null)
  {
    Activity act := (Activity)this.getContext
    act.setContentView(this)
  }

  override protected Void onDraw(Canvas? canvas)
  {
    //AndGraphics g := AndGraphics(canvas)
    c := Class.forName("fan.gfx2Imp.AndGraphics")
    Graphics2 g := c.getConstructors[0]->newInstance(canvas)
    view.paint(g)
  }

  override Bool onTouchEvent(AMotionEvent? event)
  {
    return true
  }
}


class AndViewFactory : NativeViewFactory
{
  Context context

  new make(Context context)
  {
    this.context = context
  }

  override  NativeView build(View view) {
    return AndView(context, view)
  }
}