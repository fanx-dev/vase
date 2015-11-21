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
import fan.fanvasWindow.NativeEditText;
import fan.fanvasWindow.Window;

public class AndEditText extends EditText implements NativeEditText {
	fan.fanvasWindow.EditText view;
	Window win;

	public AndEditText(Context context, fan.fanvasWindow.EditText view) {
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
				((int) dirty.x + (int) dirty.w),
				((int) dirty.y + (int) dirty.h));
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
	
	private void showInputMethod() {
		InputMethodManager imm = (InputMethodManager)this.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.showSoftInput(this, InputMethodManager.SHOW_IMPLICIT);
	}

	@Override
	public void focus() {
		this.requestFocus();
		showInputMethod();
	}

	@Override
	public Window win() {
		return win;
	}

	@Override
	public void setBackgroundColor(Color ca) {
		super.setBackgroundColor((int) ca.argb);
	}

	@Override
	public void setFont(Font f) {
		Typeface tf = AndUtil.toAndFont(f);
		this.setTypeface(tf);
		this.setTextSize(f.size);
	}

	final static int inputTypeText = 1;
	final static int inputTypeIntNumber = 2;
	final static int inputTypeFloatNumber = 3;
	final static int inputTypePassword = 4;

	@Override
	public void setInputType(long t) {
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

	@Override
	public void setSelection(long start, long stop) {
		super.setSelection((int) start, (int) stop);
	}

	@Override
	public void setTextColor(Color ca) {
		this.setBackgroundColor((int) ca.argb);
	}

	@Override
	public void setTextSelectable(boolean s) {
		this.setTextSelectable(s);
	}

	@Override
	public String text() {
		String t = this.getEditableText().toString();
		return t;
	}

	@Override
	public void text(String t) {
		super.setText(t);
		//super.setTextKeepState(t);
		super.setSelection(t.length());
	}
	
	@Override
	public void setBound(long x, long y, long w, long h) {
		this.setWidth((int)w);
		this.setHeight((int)h);
		FrameLayout.LayoutParams param = new FrameLayout.LayoutParams(
				(int)w, (int)h);
		param.setMargins((int)x, (int)y, 0, 0);
		this.setLayoutParams(param);
	}
}