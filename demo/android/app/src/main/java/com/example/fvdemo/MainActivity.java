package com.example.fvdemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

//import android.app.Activity;
//import android.os.Bundle;
//import fan.vaseAndroid.AndWindow;

import fan.vaseAndroid.AndroidEnv;
import fan.vaseDemo.WinTest;
import fanjardist.Main;

public class MainActivity extends AppCompatActivity {
    static {
        Main.boot();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);

        AndroidEnv.init(this);
        WinTest.make().main();
    }
}
