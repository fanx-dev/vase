//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.fanvasAndroid;

import android.content.Context;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.FrameLayout;
import fan.fanvasGraphics.Color;
import fan.fanvasGraphics.Font;
import fan.fanvasGraphics.Point;
import fan.fanvasGraphics.Size;
import fan.fanvasWindow.TextInput;
import fan.fanvasWindow.TextInputPeer;
import fan.fanvasWindow.Window;

public class AndEditText extends EditText implements TextInputPeer {
	fan.fanvasWindow.TextInput view;

	public AndEditText(Context context, fan.fanvasWindow.TextInput view) {
		super(context);
		this.view = view;

		this.addTextChangedListener(new TextWatcher() {
			@Override
			public void afterTextChanged(Editable e) {
				// AndEditText.this.view.didTextChange(e.toString());
			}

			@Override
			public void beforeTextChanged(CharSequence str, int arg1, int arg2,
					int arg3) {
				AndEditText.this.view.willTextChange(str.toString());
			}

			@Override
			public void onTextChanged(CharSequence str, int arg1, int arg2,
					int arg3) {
				AndEditText.this.view.didTextChange(str.toString());
			}
		});
	}
	
//	void onFocusChanged(boolean focused, int direction, Rect previouslyFocusedRect)
//	{
//		InputMethodManager imm = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE); 
//        imm.hideSoftInputFromWindow(edit.getWindowToken(),0); 
//	}
//	
//	protected void onTextChanged(CharSequence text, int start, int lengthBefore, int lengthAfter) {
//		AndEditText.this.view.onTextChanged(text.toString());
//	}
	
	private void showInputMethod() {
		InputMethodManager imm = (InputMethodManager)this.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.showSoftInput(this, InputMethodManager.SHOW_IMPLICIT);
	}

	private void hideInputMethod() {
	  InputMethodManager imm = (InputMethodManager)this.getContext().getSystemService(Context.INPUT_METHOD_SERVICE); 
	  imm.hideSoftInputFromWindow(this.getWindowToken(),0);
  }

  @Override
  public void close() {
  	hideInputMethod();
  }

  @Override
  public void update() {
  	setInputType(view.inputType());

  	Typeface tf = AndUtil.toAndFont(view.font());
		this.setTypeface(tf);
		this.setTextSize(0, (float)view.font().size);

		super.setBackgroundColor((int)view.backgroundColor().argb);
  	super.setTextColor((int)view.textColor().argb);

  	Point pos = view.getPos();
  	Size size = view.getSize();
  	setBound(pos.x, pos.y, size.w, size.h);

  	//TODO
  	//this.setTextIsSelectable(view.selectable());
  	this.setSingleLine(view.singleLine());

  	String text = view.text();
  	super.setText(text);
		//super.setTextKeepState(t);
		super.setSelection(text.length());

		this.requestFocus();
		showInputMethod();
  }

	final static int inputTypeText = 1;
	final static int inputTypeIntNumber = 2;
	final static int inputTypeFloatNumber = 3;
	final static int inputTypePassword = 4;

	private void setInputType(long t) {
		int type = 0;
		switch ((int) t) {
		case inputTypeText:
			type = InputType.TYPE_CLASS_TEXT;
			break;
		case inputTypeIntNumber:
			type = InputType.TYPE_CLASS_NUMBER;
			break;
		case inputTypeFloatNumber:
			type = InputType.TYPE_NUMBER_FLAG_DECIMAL;
			break;
		case inputTypePassword:
			type = InputType.TYPE_TEXT_VARIATION_PASSWORD;
			break;
		}
		super.setInputType(type);
	}

	/*
	public void setSelection(long start, long stop) {
		super.setSelection((int) start, (int) stop);
	}
	*/
	
	private void setBound(long x, long y, long w, long h) {
		this.setWidth((int)w);
		this.setHeight((int)h);
		FrameLayout.LayoutParams param = new FrameLayout.LayoutParams(
				(int)w, (int)h);
		param.setMargins((int)x, (int)y, 0, 0);
		this.setLayoutParams(param);
	}
}