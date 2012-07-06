//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.fanWt;

import java.awt.geom.Path2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.imageio.ImageIO;

import fan.fan2d.*;
import fan.sys.Func;
import fan.sys.IOErr;
import fan.sys.InStream;
import fan.sys.SysInStream;
import fan.sys.Uri;

public class AwtGfxEnv extends GfxEnv {

  static final AwtGfxEnv instance = new AwtGfxEnv();
  private AwtGfxEnv() {}

  @Override
  public boolean contains(Path path, double x, double y) {
    Path2D p = AwtUtil.toAwtPath(path);
    return p.contains(x, y);
  }

  @Override
  public Image fromUri(Uri uri, Func onLoad) {
    onLoad = (Func) onLoad.toImmutable();
    if (uri.scheme().equals("http")) {
      AwtImage p = new AwtImage();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InputStream jin = SysInStream.java(((fan.sys.File) uri.get()).in());
    AwtImage p = new AwtImage();
    streamToImage(jin, p);
    onLoad.call(p);
    return p;
  }

  public Image fromStream(InStream in)
  {
    InputStream jin = SysInStream.java(in);
    AwtImage p = new AwtImage();
    streamToImage(jin, p);
    return p;
  }

  private static void loadFromWeb(final AwtImage p, final Uri uri,
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

  private static void streamToImage(InputStream jin, AwtImage p) {
    BufferedImage image;
    try {
      image = ImageIO.read(jin);
    } catch (IOException e) {
      throw IOErr.make(e);
    }
    p.setImage(image);
  }

  @Override
  public Image makeImage(Size size) {
    BufferedImage image = new BufferedImage((int) size.w, (int) size.h,
        BufferedImage.TYPE_INT_ARGB);
    AwtImage p = new AwtImage();
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
    
    BufferedImage image;
    try {
      image = ImageIO.read(jin);
    } catch (IOException e) {
      throw IOErr.make(e);
    }
	  return new AwtConstImage(image);
  }

	@Override
  public Font makeFont(Func func) {
	  Font f = new AwtFont();
	  func.call(f);
	  return f;
  }

	@Override
  public PointArray makePointArray(long size) {
		PointArray pa = new AwtPointArray((int)size);
	  return pa;
  }

}