//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.fgfxAndroid;

import android.app.Activity;
import android.content.Context;
import android.view.inputmethod.InputMethodManager;
import fan.fgfxGraphics.Size;
import fan.fgfxWtk.NativeView;
import fan.fgfxWtk.View;

public class AndWindow extends android.widget.FrameLayout implements fan.fgfxWtk.Window {
  //fan.fgfxWtk.View view;
  java.util.List<View> list = new java.util.ArrayList<View>();

  public AndWindow(Context context) {
    super(context);
  }

  @Override
  public fan.fgfxWtk.Window add(fan.fgfxWtk.View view) {
    NativeView andView;
    if (view instanceof fan.fgfxWtk.EditText) {
      andView = new AndEditText(getContext(), (fan.fgfxWtk.EditText)view);
      ((AndEditText)andView).win = this;
    } else {
      andView = new AndView(getContext(), view);
      ((AndView)andView).win = this;
    }
    view.nativeView(andView);
    this.addView((android.view.View)andView);
    list.add(view);
    return this;
  }
  
  private void hideInputMethod(android.view.View aview) {
	  InputMethodManager imm = (InputMethodManager)this.getContext().getSystemService(Context.INPUT_METHOD_SERVICE); 
	  imm.hideSoftInputFromWindow(aview.getWindowToken(),0);
  }

  @Override
  public void remove(View view) {
    list.remove(view);
    android.view.View aview = ((android.view.View)view.nativeView());
    this.removeView(aview);
    
    hideInputMethod(aview);
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