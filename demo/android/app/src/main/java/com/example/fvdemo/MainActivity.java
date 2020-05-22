package com.example.fvdemo;

import android.Manifest;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Build;
//import androidx.core.content.ContextCompat;
import android.content.pm.PackageManager;

import fan.vaseAndroid.AndroidEnv;
import fan.vaseDemo.Main;

public class MainActivity extends Activity {
    static {
        Log.d("fvdemo", "init");
        fanjardist.Main.boot();
    }

    Main mainView = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);

        Log.d("fvdemo", "onCreate");

        AndroidEnv.init(this);
        if (mainView == null) mainView = Main.make();
        mainView.show();

        requestPermissions(this, new String[] {
                Manifest.permission.INTERNET,
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.CAMERA
        }, 1001);
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

    public static boolean checkPermissions(Activity ac, String[] permissions) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true;
        }
        for (String permission : permissions) {
            if (ContextCompat.checkSelfPermission(ac, permission) != PackageManager.PERMISSION_GRANTED ||
                    ActivityCompat.shouldShowRequestPermissionRationale(ac, permission)) {
                return false;
            }
        }
        return true;
    }

    public static void requestPermissions(Activity ac, String[] permissions, int requestCode) {
        if (checkPermissions(ac, permissions)) {
            return;
        }
        ActivityCompat.requestPermissions(ac, permissions, requestCode);
    }
}
