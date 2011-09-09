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

  @Override
  public boolean contains(Path path, double x, double y) {
    Path2D p = AwtUtil.toAwtPath(path);
    return p.contains(x, y);
  }

  @Override
  public Image2 fromUri(Uri uri, Func onLoad) {
    if (uri.scheme().equals("http"))
    {
      AwtImage2 p = new AwtImage2();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InputStream jin = SysInStream.java(((fan.sys.File)uri.get()).in());
    BufferedImage image;
    try {
      image = ImageIO.read(jin);
    } catch (IOException e) {
      throw IOErr.make(e);
    }
    AwtImage2 p = new AwtImage2(image);
    onLoad.call(p);
    return p;
  }

  private void loadFromWeb(final AwtImage2 p, final Uri uri, final Func onLoad) {
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

        BufferedImage image;
        try {
          image = ImageIO.read(jin);
        } catch (IOException e) {
          throw IOErr.make(e);
        }
        p.setImage(image);
        onLoad.call(p);
      }
    }).start();
  }

  @Override
  public Image2 makeImage2(Size size) {
    BufferedImage image =  new BufferedImage((int)size.w, (int)size.h,
        BufferedImage.TYPE_INT_ARGB);
    AwtImage2 p = new AwtImage2(image);
    return p;
  }

}