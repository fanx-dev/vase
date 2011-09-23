//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.gfx2Imp;

import java.awt.geom.Path2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.imageio.ImageIO;

import fan.gfx.Size;
import fan.gfx2.GfxEnv2;
import fan.gfx2.Image2;
import fan.gfx2.Path;
import fan.sys.Func;
import fan.sys.IOErr;
import fan.sys.SysInStream;
import fan.sys.Uri;

public class AwtGfxEnv2 extends GfxEnv2 {

  static final AwtGfxEnv2 instance = new AwtGfxEnv2();
  private AwtGfxEnv2() {}

  @Override
  public boolean contains(Path path, double x, double y) {
    Path2D p = AwtUtil.toAwtPath(path);
    return p.contains(x, y);
  }

  @Override
  public Image2 fromUri(Uri uri, Func onLoad) {
    onLoad = (Func) onLoad.toImmutable();
    if (uri.scheme().equals("http")) {
      AwtImage2 p = new AwtImage2();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InputStream jin = SysInStream.java(((fan.sys.File) uri.get()).in());
    AwtImage2 p = new AwtImage2();
    streamToImage(jin, p);
    onLoad.call(p);
    return p;
  }

  private static void loadFromWeb(final AwtImage2 p, final Uri uri,
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

  private static void streamToImage(InputStream jin, AwtImage2 p) {
    BufferedImage image;
    try {
      image = ImageIO.read(jin);
    } catch (IOException e) {
      throw IOErr.make(e);
    }
    p.setImage(image);
  }

  @Override
  public Image2 makeImage2(Size size) {
    BufferedImage image = new BufferedImage((int) size.w, (int) size.h,
        BufferedImage.TYPE_INT_ARGB);
    AwtImage2 p = new AwtImage2();
    p.setImage(image);
    return p;
  }

}