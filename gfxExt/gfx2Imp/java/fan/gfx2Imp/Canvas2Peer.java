//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-14  Jed Young  Creation
//

package fan.gfx2Imp;

import fan.sys.*;
import fan.fwt.*;
import fan.gfx.*;
import fan.gfx2.*;

import java.awt.Frame;
import java.awt.Graphics2D;

import org.eclipse.swt.*;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.widgets.*;
import org.eclipse.swt.widgets.Widget;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.layout.*;
import org.eclipse.swt.events.*;
import org.eclipse.swt.awt.SWT_AWT;

public class Canvas2Peer extends CanvasPeer implements PaintListener
{
  public static Canvas2Peer make(Canvas2 self)
    throws Exception
  {
    Canvas2Peer peer = new Canvas2Peer();
    ((fan.fwt.Widget)self).peer = peer;
    peer.self = self;
    return peer;
  }

  Display display = null;

  public Widget create(Widget parent)
  {
    String name = Gfx2.engineName();
    int style = SWT.NO_BACKGROUND;
    if ("AWT".equals(name)) style |= SWT.EMBEDDED;
    if (((Canvas2)self).buffered()) style |= SWT.DOUBLE_BUFFERED;
    Canvas c = new Canvas((Composite)parent, style);

    if (name == null || name.equals("SWT"))
    {
      c.addPaintListener(this);
    }
    else if (name.equals("AWT"))
    {
      Frame frame = SWT_AWT.new_Frame(c);
      AwtCanvas awtC = new AwtCanvas();
      awtC.self = (Canvas2)this.self;
      frame.add(awtC);
    }

    display = Display.getCurrent();
    return c;
  }

  public void paintControl(PaintEvent e)
  {
    Graphics2 g = new FwtGraphics2(e);
    try
    {
      ((Canvas2)self).onPaint(g);
      ((Canvas2)self).onPaint2(g);
    }
    finally
    {
      g.dispose();
    }
  }

  public void setCaret(Canvas2 self, long x, long y, long w, long h)
  {
    Caret caret = new Caret((Canvas)this.control(), SWT.NONE);
    caret.setBounds((int)x, (int)y, (int)w, (int)h);
  }

  public class AwtCanvas extends java.awt.Canvas{
    public Canvas2 self;

    private boolean lock;

    public void paint(java.awt.Graphics gc)
    {
      final Graphics2 g = new AwtGraphics((java.awt.Graphics2D)gc);
      Gfx2.setEngine("AWT");

      if (java.lang.Thread.currentThread() != display.getThread())
      {
        asyncPaint(g);
        return;
      }

      try
      {
        (self).onPaint(g);
        (self).onPaint2(g);
      }
      finally
      {
        g.dispose();
      }
    }

    private void asyncPaint(final Graphics2 g)
    {
      final Runnable runnable = new Runnable()
      {
        public void run()
        {
          try
          {
            (self).onPaint(g);
            (self).onPaint2(g);
          }
          finally
          {
            g.dispose();
            lock = false;
          }
        }
      };
      lock = true;
      display.asyncExec(runnable);
      while (lock) {}
    }
  }
}