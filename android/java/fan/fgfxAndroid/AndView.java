//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.fgfxAndroid;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.view.MotionEvent;
import android.view.View;
import fan.fgfxGraphics.Point;
import fan.fgfxGraphics.Size;
import fan.fgfxWtk.NativeView;
import fan.fgfxWtk.Window;
import fan.sys.List;

public class AndView extends View implements NativeView {
  fan.fgfxWtk.View view;
  Window win;
  
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
  public void repaint(fan.fgfxGraphics.Rect dirty) {
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
    return true;
  }
  
  @Override
  public Window win() {
	  return win;
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
    long type = fan.fgfxWtk.MotionEvent.other;
    long pointerId = 0;
    switch (e.getAction() & MotionEvent.ACTION_MASK) {
    case MotionEvent.ACTION_DOWN:
      type = fan.fgfxWtk.MotionEvent.pressed;
      break;
    case MotionEvent.ACTION_POINTER_DOWN:
      pointerId = e.getActionIndex();
      type = fan.fgfxWtk.MotionEvent.pressed;
      break;
    case MotionEvent.ACTION_MOVE:
      type = fan.fgfxWtk.MotionEvent.moved;
      break;
    case MotionEvent.ACTION_UP:
      type = fan.fgfxWtk.MotionEvent.released;
      break;
    case MotionEvent.ACTION_POINTER_UP:
      pointerId = e.getActionIndex();
      type = fan.fgfxWtk.MotionEvent.released;
      break;
    case MotionEvent.ACTION_CANCEL:
      type = fan.fgfxWtk.MotionEvent.cancel;
      break;
    }

    fan.fgfxWtk.MotionEvent ce = fan.fgfxWtk.MotionEvent.make(type);
    ce.pointerId(pointerId);
    ce.x((long)e.getX(i));
    ce.y((long)e.getY(i));
    ce.pressure((double) e.getPressure(i));
    ce.size((double) e.getSize(i));
    return ce;
  }
}