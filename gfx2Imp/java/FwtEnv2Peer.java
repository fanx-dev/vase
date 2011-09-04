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

public class FwtEnv2Peer
{
  static final FwtEnv2Peer singleton = new FwtEnv2Peer();

  public static FwtEnv2Peer make(fan.gfx2Imp.FwtEnv2 self)
  {
    return singleton;
  }

  public Pixmap fromUri(FwtEnv2 self, Uri uri, Func onLoad)
  {
    if (uri.scheme().equals("http"))
    {
      PixmapImp p = new PixmapImp();
      loadFromWeb(p, uri, onLoad);
      return p;
    }

    InputStream jin = SysInStream.java(((fan.sys.File)uri.get()).in());
    Image image = new Image(getDisplay(), jin);
    Pixmap p = new PixmapImp(image);
    onLoad.call(p);
    return p;
  }

  private void loadFromWeb(final PixmapImp p, final Uri uri, final Func onLoad)
  {
    new Thread(new Runnable(){
      public void run() {
        InputStream jin;
        try
        {
          URL requestUrl = new URL( uri.toStr() );
          URLConnection con = requestUrl.openConnection();
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

  public Pixmap makePixmap(FwtEnv2 self, Size size)
  {
    Image image = new Image(getDisplay(), (int)size.w, (int)size.h);
    return new PixmapImp(image);
  }

  public boolean contains(FwtEnv2 self, Path path, double x, double y)
  {
    return FwtGraphics2.toSwtPath(path).contains((float)x, (float)y, fan.fwt.Fwt.get().scratchGC(), false);
  }

  public static Display getDisplay() { return Display.getCurrent(); }
}