//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.fgfxAndroid;

import fan.fgfxWtk.*;
import fan.fgfxGraphics.*;
import fan.sys.*;
import android.view.View;
import android.content.Context;
import android.graphics.Rect;
import android.app.Activity;
import android.graphics.Canvas;
import android.view.MotionEvent;

public class AndWindow extends android.widget.FrameLayout implements fan.fgfxWtk.Window {
  //fan.fgfxWtk.View view;
  java.util.List list = new java.util.ArrayList();

  public AndWindow(Context context) {
    super(context);
  }

  @Override
  public fan.fgfxWtk.Window add(fan.fgfxWtk.View view) {
    AndView andView = new AndView(getContext(), view);
    view.nativeView(andView);
    this.addView(andView);
    list.add(view);
    return this;
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
}