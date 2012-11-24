//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.fgfxAndroid;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Region;
import fan.fgfx2d.ConstImage;
import fan.fgfx2d.Font;
import fan.fgfx2d.GfxEnv;
import fan.fgfx2d.Image;
import fan.fgfx2d.Path;
import fan.fgfx2d.PointArray;
import fan.fgfx2d.Size;
import fan.sys.Func;
import fan.sys.IOErr;
import fan.sys.InStream;
import fan.sys.SysInStream;
import fan.sys.Uri;

public class AndGfxEnv extends GfxEnv{

  static final AndGfxEnv instance = new AndGfxEnv();
  private AndGfxEnv() {}

  @Override
  public boolean contains(Path path, double x, double y) {
    android.graphics.Path p = AndUtil.toAndPath(path);
    Region r = new Region();
    r.setPath(p, null);
    return r.contains((int) x, (int) y);
  }

  @Override
  public Image fromStream(InStream in) {
    InputStream jin = SysInStream.java(in);
    Bitmap image = BitmapFactory.decodeStream(jin);
    AndImage p = new AndImage();
    p.setImage(image);
    return p;
  }

  @Override
  public Image fromUri(Uri uri, Func onLoad) {

    if (uri.scheme().equals("http")) {
      onLoad = (Func) onLoad.toImmutable();
      AndImage p = new AndImage();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InputStream jin = SysInStream.java(((fan.sys.File) uri.get()).in());
    Bitmap image = BitmapFactory.decodeStream(jin);
    AndImage p = new AndImage();
    p.setImage(image);
    onLoad.call(p);
    return p;
  }

  private static void loadFromWeb(final AndImage p, final Uri uri, final Func onLoad) {
    new Thread(new Runnable() {
      public void run() {
        InputStream jin;
        try {
          URL requestUrl = new URL(uri.toStr());
          URLConnection con = requestUrl.openConnection();
          jin = con.getInputStream();
        } catch (IOException e) {
          throw IOErr.make(e);
        }

        Bitmap image = BitmapFactory.decodeStream(jin);
        p.setImage(image);
        onLoad.call(p);
      }
    }).start();
  }

  @Override
  public ConstImage makeConstImage(Uri uri) {
    InputStream jin;

    if (uri.scheme().equals("http")) {
      try {
        URL requestUrl = new URL(uri.toStr());
        URLConnection con = requestUrl.openConnection();
        jin = con.getInputStream();
      } catch (IOException e) {
        throw IOErr.make(e);
      }
    } else {
      jin = SysInStream.java(((fan.sys.File) uri.get()).in());
    }

    Bitmap image = BitmapFactory.decodeStream(jin);
    AndConstImage img = new AndConstImage();
    img.setImage(image);
    return img;
  }

  @Override
  public Font makeFont(Func func) {
    return AndFont.makeFont(func);
  }

  @Override
  public Image makeImage(Size size) {
    Bitmap image = Bitmap.createBitmap((int) size.w, (int) size.h,
        Bitmap.Config.ARGB_4444);
    AndImage p = new AndImage();
    p.setImage(image);
    return p;
  }

  @Override
  public PointArray makePointArray(long size) {
    return new AndPointArray((int)size);
  }

}