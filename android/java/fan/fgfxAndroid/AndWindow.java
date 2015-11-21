//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.fanvasAndroid;

import android.app.Activity;
import android.content.Context;
import android.view.inputmethod.InputMethodManager;
import fan.fanvasGraphics.Size;
import fan.fanvasWindow.NativeView;
import fan.fanvasWindow.View;

public class AndWindow extends android.widget.FrameLayout implements fan.fanvasWindow.Window {
  //fan.fanvasWindow.View view;
  java.util.List<View> list = new java.util.ArrayList<View>();

  public AndWindow(Context context) {
    super(context);
  }

  @Override
  public fan.fanvasWindow.Window add(fan.fanvasWindow.View view) {
    NativeView andView;
    if (view instanceof fan.fanvasWindow.EditText) {
      andView = new AndEditText(getContext(), (fan.fanvasWindow.EditText)view);
      ((AndEditText)andView).win = this;
    } else {
      andView = new AndView(getContext(), view);
      ((AndView)andView).win = this;
    }
    view.host(andView);
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
    android.view.View aview = ((android.view.View)view.host());
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