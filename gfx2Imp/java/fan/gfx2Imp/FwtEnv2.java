//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-14  Jed Young  Creation
//

package fan.gfx2Imp;

import fan.sys.*;
import fan.gfx.*;
import fan.gfx2.*;
import fan.fwt.Fwt;

import java.io.*;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import org.eclipse.swt.*;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.FontData;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.graphics.ImageData;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.widgets.Display;

public class FwtEnv2 extends GfxEnv2
{
  static final FwtEnv2 instance = new FwtEnv2();
  private FwtEnv2(){}

  public Image2 fromUri(Uri uri, Func onLoad)
  {
    onLoad = (Func)onLoad.toImmutable();
    if (uri.scheme().equals("http"))
    {
      Image2Imp p = new Image2Imp();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InputStream jin = SysInStream.java(((fan.sys.File)uri.get()).in());
    Image image = new Image(getDisplay(), jin);
    Image2 p = new Image2Imp(image);
    onLoad.call(p);
    return p;
  }

  public Image2 fromStream(InStream in)
  {
    InputStream jin = SysInStream.java(in);
    Image image = new Image(getDisplay(), jin);
    Image2 p = new Image2Imp(image);
    return p;
  }

  private void loadFromWeb(final Image2Imp p, final Uri uri, final Func onLoad)
  {
    new Thread(new Runnable(){
      public void run() {
        InputStream jin;
        try
        {
          URL requestUrl = new URL( uri.toStr() );
          URLConnection con = requestUrl.openConnection();
          //con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
          jin = con.getInputStream();
        }
        catch(IOException e)
        {
          throw IOErr.make(e);
        }

        Image image = new Image(getDisplay(), jin);
        p.init(image);
        onLoad.call(p);
      }
    }).start();
  }

  public Image2 makeImage2(Size size)
  {
    Image image = new Image(getDisplay(), (int)size.w, (int)size.h);
    return new Image2Imp(image);
  }

  public boolean contains(Path path, double x, double y)
  {
    return FwtGraphics2.toSwtPath(path).contains((float)x, (float)y, fan.fwt.Fwt.get().scratchGC(), false);
  }

  public static Display getDisplay() { return Display.getCurrent(); }

  public void disposeAll()
  {
    Fwt fwt = Fwt.get();
    try
    {
      fwt.disposeAllColors();
      fwt.disposeAllFonts();
      fwt.disposeAllCursors();
      fwt.disposeAllImages();
      if (!fwt.scratchGC().isDisposed()) fwt.scratchGC().dispose();
      if (!getDisplay().isDisposed()) getDisplay().dispose();
    }
    catch(Exception ex)
    {
    }
  }
}