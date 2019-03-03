//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.fanvasAndroid;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.view.MotionEvent;
import android.view.View;
import fan.fanvasGraphics.Point;
import fan.fanvasGraphics.Size;
import fan.fanvasWindow.NativeView;
import fan.fanvasWindow.Window;
import fan.sys.List;

public class AndView extends View implements NativeView {
  fan.fanvasWindow.View view;
  Window win;
  
  public AndView(Context context, fan.fanvasWindow.View view) {
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
  public void repaint(fan.fanvasGraphics.Rect dirty) {
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
    fan.fanvasWindow.MotionEvent ce = andToFan(event);
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

  static fan.fanvasWindow.MotionEvent andToFan(MotionEvent event) {
    List pointers = List.make(event.getPointerCount(), fan.fanvasWindow.MotionEvent.$Type);
    for (int i = 0, n = event.getPointerCount(); i < n; ++i) {
      pointers.add(getMotionPointer(event, i));
    }

    fan.fanvasWindow.MotionEvent ce = (fan.fanvasWindow.MotionEvent)pointers.get(0);
    ce.pointers = pointers;
    return ce;
  }

  private static fan.fanvasWindow.MotionEvent getMotionPointer(final MotionEvent e, final int i) {
    long type = fan.fanvasWindow.MotionEvent.other;
    long pointerId = 0;
    switch (e.getAction() & MotionEvent.ACTION_MASK) {
    case MotionEvent.ACTION_DOWN:
      type = fan.fanvasWindow.MotionEvent.pressed;
      break;
    case MotionEvent.ACTION_POINTER_DOWN:
      pointerId = e.getActionIndex();
      type = fan.fanvasWindow.MotionEvent.pressed;
      break;
    case MotionEvent.ACTION_MOVE:
      type = fan.fanvasWindow.MotionEvent.moved;
      break;
    case MotionEvent.ACTION_UP:
      type = fan.fanvasWindow.MotionEvent.released;
      break;
    case MotionEvent.ACTION_POINTER_UP:
      pointerId = e.getActionIndex();
      type = fan.fanvasWindow.MotionEvent.released;
      break;
    case MotionEvent.ACTION_CANCEL:
      type = fan.fanvasWindow.MotionEvent.cancel;
      break;
    }

    fan.fanvasWindow.MotionEvent ce = fan.fanvasWindow.MotionEvent.make(type);
    ce.pointerId(pointerId);
    ce.x((long)e.getX(i));
    ce.y((long)e.getY(i));
    ce.pressure((double) e.getPressure(i));
    ce.size((double) e.getSize(i));
    return ce;
  }
}