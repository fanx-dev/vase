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

import org.eclipse.swt.*;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.widgets.*;
import org.eclipse.swt.widgets.Widget;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.layout.*;
import org.eclipse.swt.events.*;

public class Canvas2Peer extends CanvasPeer implements PaintListener
{

  public static CanvasPeer make(fan.fwt.Canvas self)
    throws Exception
  {
    Canvas2Peer peer = new Canvas2Peer();
    ((fan.fwt.Widget)self).peer = peer;
    peer.self = self;
    return peer;
  }

  public Widget create(Widget parent)
  {
    Canvas c = new Canvas((Composite)parent, SWT.NO_BACKGROUND);
    c.addPaintListener(this);
    return c;
  }

  public void paintControl(PaintEvent e)
  {
    FwtGraphics2 g = new FwtGraphics2(e);
    ((Canvas2)self).onPaint(g);
    ((Canvas2)self).onPaint2(g);
    g.dispose();
  }

}