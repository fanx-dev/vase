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

  public Pixmap load(FwtEnv2 self, InStream in)
  {
    InputStream jin = SysInStream.java(in);
    Image image = new Image(getDisplay(), jin);
    return new PixmapImp(image);
  }
  public Pixmap fromUri(FwtEnv2 self, Uri uri, Func onLoad)
  {
    Pixmap p = load(self, ((fan.sys.File)uri.get()).in());
    onLoad.call(p);
    return p;
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