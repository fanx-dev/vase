package com.example.androiddemo;

import android.app.Activity;
import android.os.Bundle;
import fan.fgfxAndroid.AndWindow;
import fan.fgfxAndroid.AndroidEnv;
import fan.fgfxAndroidDemo.WinTest;
import fanjardist.Main;

public class MainActivity extends Activity {
	
	static {
		Main.boot();
	}
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		AndroidEnv.init(this);
		WinTest test = WinTest.make();
		fan.fgfxWtk.View view = test.build();
		AndWindow win = new AndWindow(this);
		win.add(view);
		win.show();
	}
}
