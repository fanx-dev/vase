//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-27  Jed Young  Creation
//

package fan.fgfxOpenGl;

import fan.sys.*;
import fan.fwt.*;

import org.eclipse.swt.*;
import org.eclipse.swt.layout.*;
import org.eclipse.swt.widgets.*;
import org.eclipse.swt.graphics.*;
import org.eclipse.swt.events.*;
import org.eclipse.swt.opengl.GLCanvas;
import org.eclipse.swt.opengl.GLData;
import org.lwjgl.opengl.GL11;
import org.lwjgl.opengl.GLContext;
import org.lwjgl.util.glu.GLU;
import org.lwjgl.LWJGLException;

public class GlCanvasPeer extends CanvasPeer implements PaintListener
{
  private LwjglGlContext gl = new LwjglGlContext();

  public static GlCanvasPeer make(GlCanvas self)
    throws Exception
  {
    GlCanvasPeer peer = new GlCanvasPeer();
    ((fan.fwt.Widget)self).peer = peer;
    peer.self = self;
    return peer;
  }

  public org.eclipse.swt.widgets.Widget create(org.eclipse.swt.widgets.Widget parent)
  {
    GLData data = new GLData ();
    data.doubleBuffer = true;

    GLCanvas c = new GLCanvas((Composite)parent, SWT.NONE, data);
    c.addPaintListener(this);

    getDisplay().asyncExec(new Runnable() {
      public void run() {
        if (!canvas().isDisposed()) {
          setCurrent();
          ((GlCanvas)self).onGlPaint(gl);
          canvas().swapBuffers();
          getDisplay().asyncExec(this);
        }
      }
    });
    return c;
  }

  public void paintControl(PaintEvent e)
  {
    //FwtGraphics g = new FwtGraphics(e);
    //((GlCanvas)self).onPaint(g);
    //((GlCanvas)self).onPaint2(g);
    //g.dispose();
  }

  public GlContext gl(GlCanvas self)
  {
    return gl;
  }

  GLCanvas canvas()
  {
    return ((GLCanvas)this.control());
  }

  void setCurrent()
  {
    canvas().setCurrent();
    try {
      GLContext.useContext(this.control());
    } catch(LWJGLException e) { e.printStackTrace(); }
  }

  static Display getDisplay() { return Display.getCurrent(); }
}