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
import fan.fanvasWindow.KeyEvent;
import fan.fanvasWindow.Key;

import android.view.ViewGroup;
//import android.view.KeyEvent;
import android.view.View;

public class AndEditText extends EditText implements TextInputPeer {
	fan.fanvasWindow.TextInput view;
  android.view.ViewGroup parent;

	public AndEditText(Context context, fan.fanvasWindow.TextInput view, android.view.ViewGroup parent) {
		super(context);
		this.view = view;
    this.parent = parent;

		this.addTextChangedListener(new TextWatcher() {
			@Override
			public void afterTextChanged(Editable e) {
				// AndEditText.this.view.didTextChange(e.toString());
			}

			@Override
			public void beforeTextChanged(CharSequence str, int arg1, int arg2,
					int arg3) {
				//AndEditText.this.view.willTextChange(str.toString());
			}

			@Override
			public void onTextChanged(CharSequence str, int arg1, int arg2,
					int arg3) {
				AndEditText.this.view.textChange(str.toString());
			}
		});

    this.setOnKeyListener(new View.OnKeyListener() {
    	@Override
    	public boolean onKey(View self, int keyCode, android.view.KeyEvent event) {
          KeyEvent ce = null;
          if (event.getAction() == android.view.KeyEvent.ACTION_DOWN) {
            ce = KeyEvent.make(KeyEvent.pressed);
          }
          else if (event.getAction() == android.view.KeyEvent.ACTION_UP) {
            ce = KeyEvent.make(KeyEvent.released);
          }
          else {
            return false;
          }

          ce.keyChar((long)event.getUnicodeChar());
          ce.key(keyCodeToKey(event.getKeyCode()));
          view.onKeyEvent(ce);
          
          return ce.consumed();
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
    if (this.parent != null) {
      this.parent.removeView(this);
    }
  	hideInputMethod();
  }
/*
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
		//super.setSelection(text.length());

		this.requestFocus();
		showInputMethod();
  }
*/

  @Override
  public void setPos(long x, long y, long w, long h) {
    setBound((int)x, (int)y, (int)w, (int)h);
  }
  @Override
  public void setStyle(Font font, Color textColor, Color backgroundColor) {
    Typeface tf = AndUtil.toAndFont(font);
    this.setTypeface(tf);
    this.setTextSize(0, (float)font.size);

    super.setBackgroundColor((int)backgroundColor.argb);
    super.setTextColor((int)textColor.argb);
  }
  @Override
  public void setText(String text) {
    super.setText(text);
  }
  @Override
  public void setType(long multiLine, long inputType, boolean editable) {
    setInputType(inputType);
    this.setSingleLine(multiLine <= 1);
    this.setFocusableInTouchMode(editable);
  }
  @Override
  public void focus() {
    this.requestFocus();
    showInputMethod();
  }


	final static int inputTypeText = 1;
	final static int inputTypeIntNumber = 2;
	final static int inputTypeFloatNumber = 3;
	final static int inputTypePassword = 4;

	private void setInputType(long t) {
		int type = InputType.TYPE_CLASS_TEXT;
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

  @Override
  public void select(long start, long end) {
    super.setSelection((int)start, (int)end);
  }

  @Override
  public long caretPos() {
    return super.getSelectionStart();
  }

  static Key keyCodeToKey(int keyCode)
  {
    // TODO FIXIT: map rest of non-alpha keys
    switch (keyCode)
    {
      case android.view.KeyEvent.KEYCODE_BACK :   return Key.backspace;
      case android.view.KeyEvent.KEYCODE_ENTER :  return Key.enter;
      case android.view.KeyEvent.KEYCODE_SPACE :  return Key.space;
      case android.view.KeyEvent.KEYCODE_DPAD_LEFT :  return Key.left;
      case android.view.KeyEvent.KEYCODE_DPAD_UP:  return Key.up;
      case android.view.KeyEvent.KEYCODE_DPAD_RIGHT :  return Key.right;
      case android.view.KeyEvent.KEYCODE_DPAD_DOWN :  return Key.down;
      case android.view.KeyEvent.KEYCODE_DEL :  return Key.delete;
      case android.view.KeyEvent.KEYCODE_SEMICOLON : return Key.semicolon;
      case android.view.KeyEvent.KEYCODE_COMMA : return Key.comma;
      case android.view.KeyEvent.KEYCODE_PERIOD : return Key.period;
      case android.view.KeyEvent.KEYCODE_SLASH : return Key.slash;
      case android.view.KeyEvent.KEYCODE_GRAVE : return Key.backtick;
      case android.view.KeyEvent.KEYCODE_LEFT_BRACKET : return Key.openBracket;
      case android.view.KeyEvent.KEYCODE_BACKSLASH : return Key.backSlash;
      case android.view.KeyEvent.KEYCODE_RIGHT_BRACKET : return Key.closeBracket;
//      case android.view.KeyEvent.KEYCODE_QUOTE : return Key.quote;
      default:  return Key.fromMask(keyCode);
    }
  }
}