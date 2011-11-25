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
using [java]java.lang.reflect::Constructor
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
    Constructor? ctor := c.getConstructors[0]
    Graphics2 g := ctor.newInstance([canvas])
    view.paint(g)
  }
  override Bool onTouchEvent(AMotionEvent? event)
  {
    e := andToFan(event)
    view.touch(e)
    return e.consumed
  }

//////////////////////////////////////////////////////////////////////////
// MotionEvent
//////////////////////////////////////////////////////////////////////////

  static MotionEvent andToFan(AMotionEvent? event)
  {
    pointers := MotionPointer[,]
    event.getPointerCount.times
    {
      pointers.add(getMotionPointer(event, it))
    }
    return MotionEvent(pointers)
  }

  private static MotionPointer getMotionPointer(AMotionEvent? e, Int i)
  {
    MotionPointer
    {
      pos = Point(e.getX(i).toInt, e.getY(i).toInt)
      pressure = e.getPressure(i)
      size = e.getSize(i)

      if (e.getActionIndex() != i)
        action = MotionAction.none
      else
        action = getAction(e.getAction)
    }
  }

  private static MotionAction getAction(Int i)
  {
    switch(i)
    {
    case AMotionEvent.ACTION_DOWN:
      return MotionAction.down
    case AMotionEvent.ACTION_MOVE:
      return MotionAction.move
    case AMotionEvent.ACTION_UP:
      return MotionAction.up
    }
    return MotionAction.none
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