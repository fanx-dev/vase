//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.vaseAndroid;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.view.MotionEvent;
import android.view.View;
import android.app.Activity;
import fan.vaseGraphics.Point;
import fan.vaseGraphics.Size;
import fan.vaseWindow.Window;
import fan.vaseWindow.TextInput;
import fan.sys.List;


public class AndWindow extends View implements Window {
  private fan.vaseWindow.View view;
  private Activity context;
  private android.widget.FrameLayout shell;
  
  public AndWindow(Activity context, fan.vaseWindow.View view) {
    super(context);
    this.view = view;
    this.context = context;
    this.shell = new android.widget.FrameLayout(context);
    shell.addView(this);
    view.host(this);
  }

  public fan.vaseWindow.View view() {
    return view;
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
  public void repaint(fan.vaseGraphics.Rect dirty) {
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
    fan.vaseWindow.MotionEvent ce = andToFan(event);
    view.onMotionEvent(ce);
    return true;
  }

  public void show(Size size) {
    Activity act = (Activity) this.getContext();
    act.setContentView(this.shell);
  }

  public void show() {
    show(null);
  }

  public void textInput(TextInput textInput) {
    if (textInput.host() == null) {
      AndEditText edit = new AndEditText(context, textInput, shell);
      textInput.host(edit);
    }

    AndEditText edit = (AndEditText)textInput.host();
    if (edit.getParent() == null) {
      this.shell.addView(edit);
    }

    //textInput.host().update();
    return;
  }

  // ////////////////////////////////////////////////////////////////////////
  // MotionEvent
  // ////////////////////////////////////////////////////////////////////////

  static fan.vaseWindow.MotionEvent andToFan(MotionEvent event) {
    List pointers = List.make(event.getPointerCount());
    for (int i = 0, n = event.getPointerCount(); i < n; ++i) {
      pointers.add(getMotionPointer(event, i));
    }

    fan.vaseWindow.MotionEvent ce = (fan.vaseWindow.MotionEvent)pointers.get(0);
    ce.pointers = pointers;
    return ce;
  }

  private static fan.vaseWindow.MotionEvent getMotionPointer(final MotionEvent e, final int i) {
    long type = fan.vaseWindow.MotionEvent.other;
    long pointerId = 0;
    switch (e.getAction() & MotionEvent.ACTION_MASK) {
    case MotionEvent.ACTION_DOWN:
      type = fan.vaseWindow.MotionEvent.pressed;
      break;
    case MotionEvent.ACTION_POINTER_DOWN:
      pointerId = e.getActionIndex();
      type = fan.vaseWindow.MotionEvent.pressed;
      break;
    case MotionEvent.ACTION_MOVE:
      type = fan.vaseWindow.MotionEvent.moved;
      break;
    case MotionEvent.ACTION_UP:
      type = fan.vaseWindow.MotionEvent.released;
      break;
    case MotionEvent.ACTION_POINTER_UP:
      pointerId = e.getActionIndex();
      type = fan.vaseWindow.MotionEvent.released;
      break;
    case MotionEvent.ACTION_CANCEL:
      type = fan.vaseWindow.MotionEvent.cancel;
      break;
    }

    fan.vaseWindow.MotionEvent ce = fan.vaseWindow.MotionEvent.make(type);
    ce.pointerId(pointerId);
    ce.x((long)e.getX(i));
    ce.y((long)e.getY(i));
    ce.pressure((double) e.getPressure(i));
    ce.size((double) e.getSize(i));
    return ce;
  }

  public FilePicker filePicker = null;
  public void fileDialog(String accept, fan.sys.Func c) {
    fileDialog(accept, c, null);
  }
  public void fileDialog(String accept, fan.sys.Func c, fan.std.Map options) {
    try {
      filePicker = new FilePicker(context);
      if (accept != null) filePicker.mimeType = accept;
      filePicker.fileDialogCallback = c;
      filePicker.showDialog();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}