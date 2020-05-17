//
// Copyright (c) 2020, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

package fan.vaseAndroid;

import java.io.File;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.view.View;
import android.widget.Toast;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.content.Context;
import android.os.Build;
import  android.os.StrictMode;
//import androidx.core.content.FileProvider;
import java.util.Locale;

public class FilePicker {
  private Activity context;

  private boolean doClip = false;
  private int clipWidth = 512;
  private int clipHeight = 512;
  private boolean usingFile = true;
  
  private String[] items = new String[] { "File", "Camera" };

  public String mimeType = "image/*";

  /* 请求码 */
  private static final int IMAGE_REQUEST_CODE = Activity.RESULT_FIRST_USER;
  private static final int CAMERA_REQUEST_CODE = Activity.RESULT_FIRST_USER + 1;
  private static final int RESULT_REQUEST_CODE = Activity.RESULT_FIRST_USER + 2;

  private String clipPath;
  private String noclipPath;

  public fan.sys.Func fileDialogCallback = null;

  public FilePicker(Activity context) {
    this.context = context;

    String locale = Locale.getDefault().getLanguage();
    if (locale.startsWith("zh")) {
      items = new String[] { "本地文件", "拍照" };
    }

    String path = Environment.getExternalStorageDirectory().getPath();
    File file = new File(path, "image");
    if (!file.exists()) {
      file.mkdir();
    }
    clipPath = path + "/image/clipImage.jpg";
    noclipPath = path + "/image/noclipImage.jpg";

    StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
    StrictMode.setVmPolicy(builder.build());
    builder.detectFileUriExposure();
  }

  public void setClipSize(int width, int height) {
    this.clipWidth = width;
    this.clipHeight = height;
    doClip = true;
  }

  /**
   * 检查是否存在SDCard
   * 
   * @return
   */
  public static boolean hasSdcard() {
    String state = Environment.getExternalStorageState();
    if (state.equals(Environment.MEDIA_MOUNTED)) {
      return true;
    } else {
      return false;
    }
  }

  public String getImagePath() {
    if (usingFile && hasSdcard()) {
      return clipPath;
    }
    return null;
  }

  /**
   * 显示选择对话框
   */
  public void showDialog() {

    new AlertDialog.Builder(context)
        .setItems(items, new DialogInterface.OnClickListener() {

          @Override
          public void onClick(DialogInterface dialog, int which) {
            switch (which) {
            case 0:
              Intent intent = new Intent();
              intent.setType(mimeType); // 设置文件类型
              intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE,true);//打开多个文件
              intent.addCategory(Intent.CATEGORY_DEFAULT);
              intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

              intent.setAction(Intent.ACTION_GET_CONTENT);
              context.startActivityForResult(intent, IMAGE_REQUEST_CODE);

              break;
            case 1:

              Intent intent2 = new Intent(
                  MediaStore.ACTION_IMAGE_CAPTURE);

              // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
              //     intent.setFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
              //     Uri contentUri = FileProvider.getUriForFile(context, 
              //         BuildConfig.APPLICATION_ID + ".fileProvider", noclipPath);
              //     intent2.putExtra(MediaStore.EXTRA_OUTPUT, contentUri);
              // } else {
                  intent2.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(noclipPath)));
              // }

              context.startActivityForResult(intent2, CAMERA_REQUEST_CODE);
              break;
            }
          }
        })
        .setNegativeButton("cancel", new DialogInterface.OnClickListener() {

          @Override
          public void onClick(DialogInterface dialog, int which) {
            dialog.dismiss();
          }
        }).show();

  }

  private void resultCallback(Object obj, boolean isList) {
    if (fileDialogCallback == null) return;
    if (isList) {
      fileDialogCallback.call(obj);
      return;
    }

    fan.sys.List list = fan.sys.List.makeObj(1);

    if (obj instanceof String) {
      obj = fan.std.File.fromPath((String)obj);
    }
    list.add(obj);
    fileDialogCallback.call(list);
  }

  /**
   * 获取结果
   * 
   * @param requestCode
   * @param resultCode
   * @param data
   * @return
   */
  public Object onActivityResult(int requestCode, int resultCode, Intent data) {
    if (resultCode != Activity.RESULT_CANCELED) {
      switch (requestCode) {
      case IMAGE_REQUEST_CODE:

        if (doClip) {
            startPhotoZoom(data.getData());
        }
        else {

          if (data.getClipData() != null) {
              int numberOfImages = data.getClipData().getItemCount();
              fan.sys.List list = fan.sys.List.makeObj(numberOfImages);
              for (int i = 0; i < numberOfImages; i++) {
                  try {
                    Uri uri = data.getClipData().getItemAt(i).getUri();
                    //System.out.println("clipData:"+uri+","+numberOfImages);
                    String file = UriUtil.getFilePathByUri(context, uri);
                    list.add(fan.std.File.fromPath(file));
                  } catch (Exception e) {
                    e.printStackTrace();
                  }
              }
              resultCallback(list, true);
              return list;
           }

           Uri uri = data.getData();
           //String file = getUriFile(uri);
           String file = UriUtil.getFilePathByUri(context, uri);

           //System.out.println(uri.toString() + " => " + file);
           resultCallback(file, false);
           return file;
        }
        break;
      case CAMERA_REQUEST_CODE:
        if (hasSdcard()) {
          File tempFile = new File(noclipPath);

          if (doClip) {
            startPhotoZoom(Uri.fromFile(tempFile));
          }
          else {
            resultCallback(tempFile, false);
            return tempFile;
          }

        } else {
          Toast.makeText(context, "未找到存储卡，无法存储照片！", Toast.LENGTH_LONG)
              .show();
        }

        break;
      case RESULT_REQUEST_CODE:
        if (usingFile) {
          resultCallback(clipPath, false);
          return clipPath;
        }
        if (data != null) {
          Bitmap image = getImageToView(data);
          resultCallback(image, false);
          return image;
        }
        break;
      }
    }
    return null;
  }

  /**
   * 裁剪图片方法实现
   * 
   * @param uri
   */
  private void startPhotoZoom(Uri uri) {
    Intent intent = new Intent("com.android.camera.action.CROP");
    intent.setDataAndType(uri, "image/*");
    // 设置裁剪
    intent.putExtra("crop", "true");
    // aspectX aspectY 是宽高的比例
    intent.putExtra("aspectX", 1);
    intent.putExtra("aspectY", 1);
    // outputX outputY 是裁剪图片宽高
    intent.putExtra("outputX", clipWidth);
    intent.putExtra("outputY", clipHeight);
    intent.putExtra("noFaceDetection", true);
    intent.putExtra("scale", true);
    if (usingFile) {
      intent.putExtra("return-data", false);
      intent.putExtra("outputFormat",
          Bitmap.CompressFormat.JPEG.toString());

      // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
      //     intent.setFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
      //     Uri contentUri = FileProvider.getUriForFile(context, 
      //         BuildConfig.APPLICATION_ID + ".fileProvider", clipPath);
      //     intent.putExtra(MediaStore.EXTRA_OUTPUT, contentUri);
      // } else {
          intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(clipPath)));
      // }
    } else {
      intent.putExtra("return-data", true);
    }
    context.startActivityForResult(intent, RESULT_REQUEST_CODE);
  }

  /**
   * 保存裁剪之后的图片数据
   * 
   * @param picdata
   */
  private Bitmap getImageToView(Intent data) {
    Bundle extras = data.getExtras();
    if (extras != null) {
      Bitmap photo = extras.getParcelable("data");
      return photo;
    }
    return null;
  }

  private String getUriFile(Uri uri) {
    String path = null;
    String[] projection = { "_data" }; 
    Cursor cursor = context.getContentResolver().query(uri, projection, null, null, null);
    if (cursor == null) {
        path = uri.getPath();
        return path;
    }
    if (cursor.moveToFirst()) {
        path = cursor.getString(cursor.getColumnIndex("_data"));
    }
    
    cursor.close();
    return path;
  }
}
