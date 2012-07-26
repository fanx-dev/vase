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

public class AndView extends View implements Window {
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
  public void show(Size size) {
    Activity act = (Activity) this.getContext();
    act.setContentView(this);
  }

  @Override
  public void show() {
    show(null);
  }

  @Override
  protected void onDraw(Canvas canvas) {
    // AndGraphics g := AndGraphics(canvas)
    // c := Class.forName("fan.gfx2Imp.AndGraphics");
    // Constructor? ctor := c.getConstructors[0]
    // Graphics g := ctor.newInstance([canvas])
    // view.onPaint(g)
  }

  @Override
  public boolean onTouchEvent(MotionEvent event) {
    fan.fgfxWtk.MotionEvent e = andToFan(event);

    fan.fgfxWtk.InputEvent ce = fan.fgfxWtk.InputEvent.make(InputEvent.touchEvent);
    if (e.isDown())
      ce.type = InputEventType.press;
    else if (e.isUp())
      ce.type = InputEventType.release;
    else if (e.isMove())
      ce.type = InputEventType.move;

    ce.x(e.pos().x);
    ce.y(e.pos().y);
    ce.rawEvent(e);

    view.onEvent(ce);
    return e.consumed();
  }

  // ////////////////////////////////////////////////////////////////////////
  // MotionEvent
  // ////////////////////////////////////////////////////////////////////////

  static fan.fgfxWtk.MotionEvent andToFan(MotionEvent event) {
    List pointers = List.make(MotionPointer.$Type, event.getPointerCount());

    for (int i = 0, n = event.getPointerCount(); i < n; ++i) {
      pointers.add(getMotionPointer(event, i));
    }
    return fan.fgfxWtk.MotionEvent.make(pointers);
  }

  private static MotionPointer getMotionPointer(final MotionEvent e, final int i) {
    return MotionPointer.make(new Func.Indirect1() {
      @Override
      public Object call(Object obj) {
        MotionPointer it = (MotionPointer) obj;
        it.pos = fan.fgfx2d.Point.make((int) e.getX(i), (int) e.getY(i));
        it.pressure = (double) e.getPressure(i);
        it.size = (double) e.getSize(i);

        if (e.getActionIndex() != i)
          it.action = MotionAction.none;
        else
          it.action = getAction(e.getAction());
        return null;
      }
    });
  }

  private static MotionAction getAction(int i) {
    switch (i) {
    case MotionEvent.ACTION_DOWN:
      return MotionAction.down;
    case MotionEvent.ACTION_MOVE:
      return MotionAction.move;
    case MotionEvent.ACTION_UP:
      return MotionAction.up;
    }
    return MotionAction.none;
  }
}