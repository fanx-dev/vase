//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.vaseWindow;

import java.awt.geom.Path2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.imageio.ImageIO;

import fan.vaseGraphics.*;
import fan.sys.Func;
import fan.sys.IOErr;
import fan.std.InStream;
import fan.std.SysInStream;
import fan.std.Uri;
import fanx.interop.Interop;

public class WtkGfxEnv extends GfxEnv {

  static final WtkGfxEnv instance = new WtkGfxEnv();
  private WtkGfxEnv() {}

  @Override
  public boolean contains(Path path, double x, double y) {
    Path2D p = WtkUtil.toAwtPath(path);
    return p.contains(x, y);
  }

  @Override
  public Image fromUri(Uri uri, Func onLoad) {
    if ("http".equals(uri.scheme) || "https".equals(uri.scheme)) {
      onLoad = (Func) onLoad.toImmutable();
      WtkImage p = new WtkImage();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InStream fin = null;
    if (uri.scheme != null) {
      fin = ((fan.std.File) uri.get()).in();
    }
    else {
      fin = ((fan.std.File) uri.toFile()).in();
    }
    InputStream jin = Interop.toJava(fin);
    WtkImage p = new WtkImage();
    streamToImage(jin, p);
    fin.close();
    if (onLoad != null) onLoad.call(p);
    return p;
  }

  public Image fromStream(InStream in)
  {
    InputStream jin = Interop.toJava(in);
    WtkImage p = new WtkImage();
    streamToImage(jin, p);
    return p;
  }

  public void _swapImage(Image dscImg, Image newImg) {
    BufferedImage b = ((WtkImage)dscImg).getImage();
    ((WtkImage)dscImg).setImage(((WtkImage)newImg).getImage());
    ((WtkImage)newImg).setImage(b);
  }

  private static void loadFromWeb(final Image p, final Uri uri,
      final Func onLoad) {
    Object v = fan.concurrent.Actor.locals().get("vaseWindow.loadImage");
    if (v == null) throw fan.sys.Err.make("not found vaseWindow.loadImage");
    ((Func)v).call(p, uri, onLoad);
  }

  private static void streamToImage(InputStream jin, WtkImage p) {
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
    WtkImage p = new WtkImage();
    p.setImage(image);
    return p;
  }

  @Override
  public Font makeFont(Func func) {
    return WtkFont.makeAwtFont(func);
  }

  @Override
  public PointArray makePointArray(long size) {
    PointArray pa = new WtkPointArray((int)size);
    return pa;
  }

}