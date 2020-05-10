package com.example.fvdemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import fan.vaseAndroid.AndroidEnv;
import fan.vaseDemo.Main;

public class MainActivity extends Activity {
    static {
        Log.d("fvdemo", "init");
        fanjardist.Main.boot();
    }

    Main mainView = Main.make();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);

        Log.d("fvdemo", "onCreate");

        AndroidEnv.init(this);
        mainView.show();
    }

    @Override
    public void onBackPressed() {
        if (AndroidEnv.onBack(this)) return;
        super.onBackPressed();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        AndroidEnv.onActivityResult(this, requestCode, resultCode, data);
    }
}
