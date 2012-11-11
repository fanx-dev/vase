//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.fgfxAndroid;

import fan.fgfxWtk.*;
import fan.fgfx2d.*;
import fan.sys.*;
import android.view.View;
import android.content.Context;
import android.graphics.Rect;
import android.app.Activity;
import android.graphics.Canvas;
import android.view.MotionEvent;

public class AndView extends View implements NativeView {
  fan.fgfxWtk.View view;

  public AndView(Context context, fan.fgfxWtk.View view) {
    super(context);
    this.view = view;
  }

  @Override
  public Size size() {
    return Size.make(this.getWidth(), this.getHeight());
  }

  @Override
  public Point pos() {
    int x = this.getLeft();
    int y = this.getTop();
    return Point.make(x, y);
  }

  @Override
  public void repaint(fan.fgfx2d.Rect dirty) {
    if (dirty == null) {
      this.invalidate();
      return;
    }
    Rect rect = new Rect((int) dirty.x, (int) dirty.y,
        ((int) dirty.x + (int) dirty.w), ((int) dirty.y + (int) dirty.h));
    this.invalidate(rect);
  }

  @Override
  public void repaint() {
    repaint(null);
  }

  @Override
  public boolean hasFocus() {
    return super.hasFocus();
  }

  @Override
  public void focus() {
    this.requestFocus();
  }

  @Override
  protected void onDraw(Canvas canvas) {
    AndGraphics g = new AndGraphics(canvas);
    view.onPaint(g);
  }

  @Override
  public boolean onTouchEvent(MotionEvent event) {
    fan.fgfxWtk.MotionEvent ce = andToFan(event);
    view.onMotionEvent(ce);
    return ce.consumed();
  }

  // ////////////////////////////////////////////////////////////////////////
  // MotionEvent
  // ////////////////////////////////////////////////////////////////////////

  static fan.fgfxWtk.MotionEvent andToFan(MotionEvent event) {
    List pointers = List.make(fan.fgfxWtk.MotionEvent.$Type, event.getPointerCount());
    for (int i = 0, n = event.getPointerCount(); i < n; ++i) {
      pointers.add(getMotionPointer(event, i));
    }

    fan.fgfxWtk.MotionEvent ce = (fan.fgfxWtk.MotionEvent)pointers.get(0);
    ce.pointers = pointers;
    return ce;
  }

  private static fan.fgfxWtk.MotionEvent getMotionPointer(final MotionEvent e, final int i) {
    long id = e.getActionIndex() != i ? fan.fgfxWtk.MotionEvent.other : getActionId(e.getAction());
    fan.fgfxWtk.MotionEvent ce = fan.fgfxWtk.MotionEvent.make(id);
    ce.x((long)e.getX(i));
    ce.y((long)e.getY(i));
    ce.pressure((double) e.getPressure(i));
    ce.size((double) e.getSize(i));
    return ce;
  }

  private static long getActionId(int i) {
    switch (i) {
    case MotionEvent.ACTION_DOWN:
      return fan.fgfxWtk.MotionEvent.pressed;
    case MotionEvent.ACTION_MOVE:
      return fan.fgfxWtk.MotionEvent.moved;
    case MotionEvent.ACTION_UP:
      return fan.fgfxWtk.MotionEvent.released;
    }
    return fan.fgfxWtk.MotionEvent.other;
  }
}