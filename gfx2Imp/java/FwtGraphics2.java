//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-14  Jed Young  Creation
//

package fan.gfx2Imp;

import java.util.Stack;

import fan.sys.FanObj;
import fan.sys.ArgErr;

import fan.array.*;
import fan.fan3dMath.*;
import fan.gfx.*;
import fan.gfx2.*;
import fan.fwt.FwtGraphics;


import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Pattern;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.graphics.Transform;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.events.PaintEvent;

public class FwtGraphics2 extends FwtGraphics implements Graphics2
{
  GC gc;

  public FwtGraphics2(PaintEvent e)
  {
    this(e.gc, e.x, e.y, e.width, e.height);
  }

  public FwtGraphics2(GC gc, int x, int y, int w, int h)
  {
    super(gc, x, y, w, h);
    this.gc = gc;
  }

  public FwtGraphics2 drawImage2(Image2 image, long x, long y)
  {
    PixmapImp p = (PixmapImp)image;
    gc.drawImage(p.getImage(), (int)x, (int)y);
    return this;
  }
  public FwtGraphics2 copyImage2(Image2 image, Rect s, Rect d)
  {
    PixmapImp p = (PixmapImp)image;
    gc.drawImage(p.getImage(),
      (int)s.x, (int)s.y, (int)s.w, (int)s.h,
      (int)d.x, (int)d.y, (int)d.w, (int)d.h);
    return this;
  }

  public FwtGraphics2 drawPath(fan.gfx2.Path path)
  {
    gc.drawPath(toSwtPath(path));
    return this;
  }
  public FwtGraphics2 fillPath(fan.gfx2.Path path)
  {
    gc.fillPath(toSwtPath(path));
    return this;
  }

  public FwtGraphics2 drawPolyline2(Array p)
  {
    gc.drawPolyline((int[])p.peer.getValue());
    return this;
  }
  public FwtGraphics2 fillPolygon2(Array p)
  {
    gc.fillPolygon((int[])p.peer.getValue());
    return this;
  }

  public FwtGraphics2 setTransform(fan.fan3dMath.Transform2D t)
  {
    gc.setTransform(toSwtTransform(t));
    return this;
  }

  public FwtGraphics2 clipPath(Path path)
  {
    gc.setClipping(toSwtPath(path));
    return this;
  }

  public Pixmap image()
  {
    return new PixmapImp(gc.getGCData().image);
  }

  /**
   * auto free resource
   */
  @Override
  protected void finalize()
  {
    if (!gc.isDisposed()) gc.dispose();
  }


//////////////////////////////////////////////////////////////////////////
// Util
//////////////////////////////////////////////////////////////////////////

  static public org.eclipse.swt.graphics.Path toSwtPath(fan.gfx2.Path path)
  {
    int size = (int)path.steps().size();
    org.eclipse.swt.graphics.Path swtPath = new org.eclipse.swt.graphics.Path(FwtEnv2Peer.getDisplay());
    for (int i =0; i < size; ++i)
    {
      PathStep step = (PathStep)path.steps().get(i);

      if (step instanceof PathMoveTo)
      {
        PathMoveTo s = (PathMoveTo)step;
        swtPath.moveTo((float)s.x, (float)s.y);
      }
      else if (step instanceof PathLineTo)
      {
        PathLineTo s = (PathLineTo)step;
        swtPath.lineTo((float)s.x, (float)s.y);
      }
      else if (step instanceof PathQuadTo)
      {
        PathQuadTo s = (PathQuadTo)step;
        swtPath.quadTo((float)s.cx, (float)s.cy, (float)s.x, (float)s.y);
      }
      else if (step instanceof PathCubicTo)
      {
        PathCubicTo s = (PathCubicTo)step;
        swtPath.cubicTo((float)s.cx1, (float)s.cy1, (float)s.cx2, (float)s.cy2, (float)s.x, (float)s.y);
      }
      else if (step instanceof PathClose)
      {
        swtPath.close();
      }
      else
      {
        throw fan.sys.Err.make("unreachable");
      }
    }
    return swtPath;
  }

  static public Transform toSwtTransform(Transform2D trans)
  {
    return new Transform(FwtEnv2Peer.getDisplay(),
       (float)trans.get(0,0),
       (float)trans.get(1,0),
       (float)trans.get(0,1),
       (float)trans.get(1,1),
       (float)trans.get(2,0),
       (float)trans.get(2,1)
       );
  }
}