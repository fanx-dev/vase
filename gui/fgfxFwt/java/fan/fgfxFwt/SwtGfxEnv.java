//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.fgfxFwt;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import fan.fgfx2d.*;
import fan.sys.Func;
import fan.sys.IOErr;
import fan.sys.InStream;
import fan.sys.SysInStream;
import fan.sys.Uri;

public class SwtGfxEnv extends GfxEnv {

  static final SwtGfxEnv instance = new SwtGfxEnv();
  private SwtGfxEnv() {}

  @Override
  public boolean contains(Path path, double x, double y) {
    org.eclipse.swt.graphics.Path p = SwtUtil.toSwtPath(path);
    return p.contains((float)x, (float)y, SwtUtil.scratchG(), false);
  }

  @Override
  public Image fromUri(Uri uri, Func onLoad) {
    if (uri.scheme().equals("http")) {
      onLoad = (Func) onLoad.toImmutable();
      SwtImage p = new SwtImage();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InputStream jin = SysInStream.java(((fan.sys.File) uri.get()).in());
    SwtImage p = new SwtImage();
    streamToImage(jin, p);
    onLoad.call(p);
    return p;
  }

  public Image fromStream(InStream in)
  {
    InputStream jin = SysInStream.java(in);
    SwtImage p = new SwtImage();
    streamToImage(jin, p);
    return p;
  }

  private static void loadFromWeb(final SwtImage p, final Uri uri,
      final Func onLoad) {
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

        streamToImage(jin, p);
        onLoad.call(p);
      }
    }).start();
  }

  private static void streamToImage(InputStream jin, SwtImage p) {
    org.eclipse.swt.graphics.Image image = new org.eclipse.swt.graphics.Image(SwtUtil.getDisplay(), jin);
    p.setImage(image);
  }

  @Override
  public Image makeImage(Size size) {
    org.eclipse.swt.graphics.Image image = new org.eclipse.swt.graphics.Image(SwtUtil.getDisplay(), (int)size.w, (int)size.h);
    SwtImage p = new SwtImage();
    p.setImage(image);
    return p;
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

    org.eclipse.swt.graphics.Image image = new org.eclipse.swt.graphics.Image(SwtUtil.getDisplay(), jin);
    try{
      jin.close();
     } catch (IOException e) {}
    return new SwtConstImage(image);
  }

  @Override
  public Font makeFont(Func func) {
    return SwtFont.makeAwtFont(func);
  }

  @Override
  public PointArray makePointArray(long size) {
    PointArray pa = new SwtPointArray((int)size);
    return pa;
  }

}