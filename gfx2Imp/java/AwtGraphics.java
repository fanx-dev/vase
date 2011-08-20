//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-18  Jed Young  Creation
//

package fan.gfx2Imp;

import java.util.Stack;

import fan.sys.FanObj;
import fan.sys.ArgErr;

import fan.array.*;
import fan.fan3dMath.*;
import fan.gfx.*;
import fan.gfx2.*;

import java.awt.*;

public class AwtGraphics// implements Graphics2
{
/*
  Graphics2D gc;
  Pen pen = Pen.defVal;
  Brush brush = Color.black;
  Font font;
  int alpha = 255;
  Stack stack = new Stack();

  public AwtGraphics(Graphics2D gc)
  {
    this.gc = gc;
  }

  public AwtGraphics(Graphics2D gc, int x, int y, int w, int h)
  {
    this.gc = gc;
    clip(Rect.make(x, y, w, h));
  }

  public Brush brush()
  {
    return brush;
  }

  public void brush(Brush brush)
  {
    this.brush = brush;

    Pattern oldfg = gc.getForegroundPattern();
    Pattern oldbg = gc.getBackgroundPattern();
    try
    {
      if (brush instanceof Color)
      {
        int ca = (int)((Color)brush).a();
        gc.setAlpha((alpha == 255) ? ca : (int)((alpha * ca) / 255));
        org.eclipse.swt.graphics.Color c = fwt.color((Color)brush);
        gc.setForeground(c);
        gc.setBackground(c);
        gc.setForegroundPattern(null);
        gc.setBackgroundPattern(null);
      }
      else if (brush instanceof Gradient)
      {
        // can't really map SWT model to CSS model well
        Pattern p = pattern(fwt, (Gradient)brush, 0, 0, 100, 100);
        gc.setForegroundPattern(p);
        gc.setBackgroundPattern(p);
      }
      else if (brush instanceof fan.gfx.Pattern)
      {
        Pattern p = pattern(fwt, (fan.gfx.Pattern)brush);
        gc.setForegroundPattern(p);
        gc.setBackgroundPattern(p);
      }
      else
      {
        throw ArgErr.make("Unsupported brush type: " + FanObj.typeof(brush));
      }
    }
    finally
    {
      if (oldfg != null) oldfg.dispose();
      if (oldbg != null) oldbg.dispose();
    }
  }

  private Pattern pattern(Fwt fwt, Gradient g, float vx, float vy, float vw, float vh)
  {
    // only support two gradient stops
    GradientStop s1 = (GradientStop)g.stops.get(0);
    GradientStop s2 = (GradientStop)g.stops.get(-1L);
    boolean x1Percent = g.x1Unit == Gradient.percent;
    boolean y1Percent = g.y1Unit == Gradient.percent;
    boolean x2Percent = g.x2Unit == Gradient.percent;
    boolean y2Percent = g.y2Unit == Gradient.percent;

    // start
    float x1 = vx + g.x1;
    float y1 = vy + g.y1;
    float x2 = vx + g.x2;
    float y2 = vy + g.y2;

    // handle percentages
    if (x1Percent) x1 = vx + vw * g.x1/100f;
    if (y1Percent) y1 = vy + vh * g.y1/100f;
    if (x2Percent) x2 = vx + vw * g.x2/100f;
    if (y2Percent) y2 = vy + vh * g.y2/100f;

    // System.out.println(g + "[" + vx + "," + vy + "," + vw + "," + vh + "]");
    // System.out.println("  => " + x1 + "," + y1 + "  " + x2 + "," + y2);

    // alpha
    int a1 = (int)s1.color.a();
    int a2 = (int)s2.color.a();
    if (alpha != 255)
    {
      a1 = (int)((alpha * a1) / 255);
      a2 = (int)((alpha * a2) / 255);
    }

    return new Pattern(getDisplay(),
        x1, y1, x2, y2,
        fwt.color(s1.color), a1,
        fwt.color(s2.color), a2);
  }

  private Pattern pattern(Fwt fwt, fan.gfx.Pattern p)
  {
    return new Pattern(getDisplay(), fwt.image(p.image));
  }

  public Pen pen()
  {
    return pen;
  }

  public void pen(Pen pen)
  {
    this.pen = pen;
    gc.setLineWidth((int)pen.width);
    gc.setLineCap(penCap(pen.cap));
    gc.setLineJoin(penJoin(pen.join));
    gc.setLineDash(pen.dash != null ? pen.dash.toInts() : null);
  }

  private static int penCap(long cap)
  {
    if (cap == Pen.capSquare) return SWT.CAP_SQUARE;
    if (cap == Pen.capButt)   return SWT.CAP_FLAT;
    if (cap == Pen.capRound)  return SWT.CAP_ROUND;
    throw new IllegalStateException("Invalid pen.cap " + cap);
  }

  private static int penJoin(long join)
  {
    if (join == Pen.joinMiter) return SWT.JOIN_MITER;
    if (join == Pen.joinBevel) return SWT.JOIN_BEVEL;
    if (join == Pen.joinRound) return SWT.JOIN_ROUND;
    throw new IllegalStateException("Invalid pen.join " + join);
  }

  public Font font()
  {
    return font;
  }

  public void font(Font font)
  {
    this.font = font;
    this.gc.setFont(Fwt.get().font(font));
  }

  public boolean antialias()
  {
    return gc.getRenderingHint(RenderingHints.KEY_ANTIALIASING);
  }

  public void antialias(boolean on)
  {
    int val = on ? RenderingHints.VALUE_ANTIALIAS_ON : RenderingHints.VALUE_ANTIALIAS_OFF;
    gc.setRenderingHint(RenderingHints.KEY_ANTIALIASING, val);
  }

  public long alpha()
  {
    return alpha;
  }

  public void alpha(long alpha)
  {
    this.alpha = (int)alpha;
    brush(this.brush);
  }

  public Graphics drawLine(long x1, long y1, long x2, long y2)
  {
    gc.drawLine((int)x1, (int)y1, (int)x2, (int)y2);
    return this;
  }

  public Graphics drawPolyline(fan.sys.List p)
  {
    gc.drawPolyline(toInts(p));
    return this;
  }

  public Graphics drawPolygon(fan.sys.List p)
  {
    gc.drawPolygon(toInts(p));
    return this;
  }

  public Graphics fillPolygon(fan.sys.List p)
  {
    gc.fillPolygon(toInts(p));
    return this;
  }

  public Graphics drawRect(long x, long y, long w, long h)
  {
    gc.drawRectangle((int)x, (int)y, (int)w, (int)h);
    return this;
  }

  public Graphics fillRect(long x, long y, long w, long h)
  {
    // this is one case where we optimize gradients for view rect
    if (brush instanceof Gradient)
    {
      Fwt fwt = Fwt.get();
      Pattern newbg = pattern(fwt, (Gradient)brush, x, y, w, h);
      Pattern oldbg = gc.getBackgroundPattern();
      gc.setBackgroundPattern(newbg);
      gc.fillRectangle((int)x, (int)y, (int)w, (int)h);
      gc.setBackgroundPattern(oldbg);
      newbg.dispose();
    }
    else
    {
      gc.fillRectangle((int)x, (int)y, (int)w, (int)h);
    }
    return this;
  }

  public Graphics drawRoundRect(long x, long y, long w, long h, long wArc, long hArc)
  {
    gc.drawRoundRectangle((int)x, (int)y, (int)w, (int)h, (int)wArc, (int)hArc);
    return this;
  }

  public Graphics fillRoundRect(long x, long y, long w, long h, long wArc, long hArc)
  {
    // this is one case where we optimize gradients for view rect
    if (brush instanceof Gradient)
    {
      Fwt fwt = Fwt.get();
      Pattern newbg = pattern(fwt, (Gradient)brush, x, y, w, h);
      Pattern oldbg = gc.getBackgroundPattern();
      gc.setBackgroundPattern(newbg);
      gc.fillRoundRectangle((int)x, (int)y, (int)w, (int)h, (int)wArc, (int)hArc);
      gc.setBackgroundPattern(oldbg);
      newbg.dispose();
    }
    else
    {
      gc.fillRoundRectangle((int)x, (int)y, (int)w, (int)h, (int)wArc, (int)hArc);
    }
    return this;
  }

  public Graphics drawOval(long x, long y, long w, long h)
  {
    gc.drawOval((int)x, (int)y, (int)w, (int)h);
    return this;
  }

  public Graphics fillOval(long x, long y, long w, long h)
  {
    gc.fillOval((int)x, (int)y, (int)w, (int)h);
    return this;
  }

  public Graphics drawArc(long x, long y, long w, long h, long s, long a)
  {
    gc.drawArc((int)x, (int)y, (int)w, (int)h, (int)s, (int)a);
    return this;
  }

  public Graphics fillArc(long x, long y, long w, long h, long s, long a)
  {
    gc.fillArc((int)x, (int)y, (int)w, (int)h, (int)s, (int)a);
    return this;
  }

  public Graphics drawText(String text, long x, long y)
  {
    int flags = SWT.DRAW_DELIMITER | SWT.DRAW_TAB | SWT.DRAW_TRANSPARENT;
    gc.drawText(text, (int)x, (int)y, flags);
    return this;
  }

  public Graphics drawImage(Image img, long x, long y)
  {
    gc.drawImage(Fwt.get().image(img), (int)x, (int)y);
    return this;
  }

  public Graphics copyImage(Image img, Rect s, Rect d)
  {
    gc.drawImage(Fwt.get().image(img),
      (int)s.x, (int)s.y, (int)s.w, (int)s.h,
      (int)d.x, (int)d.y, (int)d.w, (int)d.h);
    return this;
  }

  public Graphics translate(long x, long y)
  {
    Transform t = new Transform(gc.getDevice());
    gc.getTransform(t);
    t.translate((int)x, (int)y);
    gc.setTransform(t);
    t.dispose();
    return this;
  }

  public Graphics clip(Rect r)
  {
    Rectangle a = gc.getClipping();
    Rectangle b = new Rectangle((int)r.x, (int)r.y, (int)r.w, (int)r.h);
    gc.setClipping(a.intersection(b));
    return this;
  }

  public Rect clipBounds()
  {
    Rectangle r = gc.getClipping();
    return fan.gfx.Rect.make(r.x, r.y, r.width, r.height);
  }

  public void dispose()
  {
    gc.dispose();
  }

//////////////////////////////////////////////////////////////////////////
// State
//////////////////////////////////////////////////////////////////////////

  public void push()
  {
    State s = new State();
    s.pen   = pen;
    s.brush = brush;
    s.font  = font;
    s.antialias = gc.getAntialias();
    s.textAntialias = gc.getTextAntialias();
    s.alpha = alpha;
    s.transform = new Transform(gc.getDevice());
    gc.getTransform(s.transform);
    s.clip = gc.getClipping();
    stack.push(s);
  }

  public void pop()
  {
    State s = (State)stack.pop();
    alpha = s.alpha;
    pen(s.pen);
    brush(s.brush);
    font(s.font);
    gc.setAntialias(s.antialias);
    gc.setTextAntialias(s.textAntialias);
    gc.setTransform(s.transform);
    s.transform.dispose();
    gc.setClipping(s.clip);
  }

  static class State
  {
    Pen pen;
    Brush brush;
    Font font;
    int antialias;
    int textAntialias;
    int alpha;
    Transform transform;
    Rectangle clip;
  }

//////////////////////////////////////////////////////////////////////////
// Graphics2
//////////////////////////////////////////////////////////////////////////

  public AwtGraphics drawImage2(Image2 image, long x, long y)
  {
    PixmapImp p = (PixmapImp)image;
    gc.drawImage(p.getImage(), (int)x, (int)y);
    return this;
  }
  public AwtGraphics copyImage2(Image2 image, Rect s, Rect d)
  {
    PixmapImp p = (PixmapImp)image;
    gc.drawImage(p.getImage(),
      (int)s.x, (int)s.y, (int)s.w, (int)s.h,
      (int)d.x, (int)d.y, (int)d.w, (int)d.h);
    return this;
  }

  public AwtGraphics drawPath(fan.gfx2.Path path)
  {
    gc.drawPath(toSwtPath(path));
    return this;
  }
  public AwtGraphics fillPath(fan.gfx2.Path path)
  {
    gc.fillPath(toSwtPath(path));
    return this;
  }

  public AwtGraphics drawPolyline2(Array p)
  {
    gc.drawPolyline((int[])p.peer.getValue());
    return this;
  }
  public AwtGraphics fillPolygon2(Array p)
  {
    gc.fillPolygon((int[])p.peer.getValue());
    return this;
  }

  public AwtGraphics setTransform(fan.fan3dMath.Transform2D t)
  {
    gc.setTransform(toSwtTransform(t));
    return this;
  }

  //*
  //* auto free resource
  //*
  @Override
  protected void finalize()
  {
    if (!gc.isDisposed()) gc.dispose();
  }


//////////////////////////////////////////////////////////////////////////
// Util
//////////////////////////////////////////////////////////////////////////

  int[] toInts(fan.sys.List points)
  {
    int size = (int)points.size() * 2;
    int[] a = new int[size];
    for (int i=0; i<size; i+=2)
    {
      Point p = (Point)points.get(i/2);
      a[i]   = (int)p.x;
      a[i+1] = (int)p.y;
    }
    return a;
  }

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
  */
}