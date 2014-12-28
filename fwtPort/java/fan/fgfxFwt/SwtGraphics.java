//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.fgfxFwt;

import java.util.Stack;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Pattern;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.graphics.Region;
import org.eclipse.swt.graphics.Transform;
import org.eclipse.swt.events.PaintEvent;

import fan.fgfxMath.Transform2D;
import fan.fgfxGraphics.*;
import fan.sys.ArgErr;
import fan.sys.FanObj;

public class SwtGraphics implements Graphics {

  GC gc;
  Pen pen = Pen.defVal;
  Brush brush = Color.black;
  Font font;
  int alpha = 255;
  Stack<State> stack = new Stack<State>();
  Transform currentTransform;

  public SwtGraphics(PaintEvent e)
  {
    this(e.gc, e.x, e.y, e.width, e.height);
  }

  public SwtGraphics(GC gc)
  {
    this.gc = gc;
  }

  public SwtGraphics(GC gc, int x, int y, int w, int h)
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
        //int ca = (int)((Color)brush).a();
        //gc.setAlpha((alpha == 255) ? ca : (int)((alpha * ca) / 255));

        org.eclipse.swt.graphics.Color c  = SwtUtil.toSwtColor((Color)brush);
        gc.setForeground(c);
        gc.setBackground(c);
        gc.setForegroundPattern(null);
        gc.setBackgroundPattern(null);
      }
      else if (brush instanceof Gradient)
      {
        // can't really map SWT model to CSS model well
        Pattern p = pattern((Gradient)brush, 0, 0, 100, 100);
        gc.setForegroundPattern(p);
        gc.setBackgroundPattern(p);
      }
      else if (brush instanceof fan.gfx.Pattern)
      {
        Pattern p = pattern((fan.fgfxGraphics.Pattern)brush);
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

  private Pattern pattern(Gradient g, float vx, float vy, float vw, float vh)
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

    return new Pattern(SwtUtil.getDisplay(),
        x1, y1, x2, y2,
        SwtUtil.toSwtColor(s1.color), a1,
        SwtUtil.toSwtColor(s2.color), a2);
  }

  private Pattern pattern(fan.fgfxGraphics.Pattern p)
  {
    return new Pattern(SwtUtil.getDisplay(), SwtUtil.toSwtImage(p.image));
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

  public void font(Font f)
  {
    this.font = f;
    if (font == null)
    {
      this.gc.setFont(null);
    }
    else
    {
      this.gc.setFont(((SwtFont)f).getNFont());
    }
  }

  public boolean antialias()
  {
    return gc.getAntialias() == SWT.ON;
  }

  public void antialias(boolean on)
  {
    int val = on ? SWT.ON : SWT.OFF;
    gc.setAntialias(val);
    gc.setTextAntialias(val);
  }

  public long alpha()
  {
    return alpha;
  }

  public void alpha(long alpha)
  {
    this.alpha = (int)alpha;
    gc.setAlpha(this.alpha);
  }

  public Graphics drawLine(long x1, long y1, long x2, long y2)
  {
    gc.drawLine((int)x1, (int)y1, (int)x2, (int)y2);
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
      Pattern newbg = pattern((Gradient)brush, x, y, w, h);
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

  public Graphics clearRect(long x, long y, long w, long h)
  {
    gc.fillRectangle((int)x, (int)y, (int)w, (int)h);
    return this;
  }

  public Graphics drawRoundRect(long x, long y, long w, long h, long wArc, long hArc)
  {
    gc.drawRoundRectangle((int)x, (int)y, (int)w, (int)h, (int)wArc*2, (int)hArc*2);
    return this;
  }

  public Graphics fillRoundRect(long x, long y, long w, long h, long wArc, long hArc)
  {
    // this is one case where we optimize gradients for view rect
    if (brush instanceof Gradient)
    {
      Pattern newbg = pattern((Gradient)brush, x, y, w, h);
      Pattern oldbg = gc.getBackgroundPattern();
      gc.setBackgroundPattern(newbg);
      gc.fillRoundRectangle((int)x, (int)y, (int)w, (int)h, (int)wArc*2, (int)hArc*2);
      gc.setBackgroundPattern(oldbg);
      newbg.dispose();
    }
    else
    {
      gc.fillRoundRectangle((int)x, (int)y, (int)w, (int)h, (int)wArc*2, (int)hArc*2);
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
    int flags = /*SWT.DRAW_DELIMITER | */SWT.DRAW_TAB | SWT.DRAW_TRANSPARENT;
    int outline = (this.font == null) ? 0 : (int)(this.font.ascent()+this.font.leading());
    gc.drawText(text, (int)x, (int)(y-outline), flags);
    return this;
  }

  public Graphics drawImage(Image img, long x, long y)
  {
    gc.drawImage(SwtUtil.toSwtImage(img), (int)x, (int)y);
    return this;
  }

  public Graphics copyImage(Image img, Rect s, Rect d)
  {
    gc.drawImage(SwtUtil.toSwtImage(img),
      (int)s.x, (int)s.y, (int)s.w, (int)s.h,
      (int)d.x, (int)d.y, (int)d.w, (int)d.h);
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
    Rectangle a = gc.getClipping();
    return Rect.make(a.x, a.y, a.width, a.height);
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

  public SwtGraphics drawPath(Path path)
  {
    org.eclipse.swt.graphics.Path p = SwtUtil.toSwtPath(path);
    gc.drawPath(p);
    p.dispose();
    return this;
  }
  public SwtGraphics fillPath(Path path)
  {
    org.eclipse.swt.graphics.Path p = SwtUtil.toSwtPath(path);
    gc.fillPath(p);
    p.dispose();
    return this;
  }

  public SwtGraphics drawPolyline(PointArray list)
  {
    SwtPointArray pa = (SwtPointArray)list;
    gc.drawPolyline(pa.array);
    return this;
  }
  public SwtGraphics fillPolygon(PointArray list)
  {
    SwtPointArray pa = (SwtPointArray)list;
    gc.fillPolygon(pa.array);
    return this;
  }

  @Override
  public Graphics drawPolygon(PointArray list) {
    SwtPointArray pa = (SwtPointArray)list;
    gc.drawPolygon(pa.array);
    return this;
  }

  @Override
  public Graphics transform(Transform2D trans) {
    if (currentTransform == null) {
      currentTransform = new Transform(SwtUtil.getDisplay());
    }
    gc.getTransform(currentTransform);
    Transform t = SwtUtil.toSwtTransform(trans);
    currentTransform.multiply(t);
    gc.setTransform(currentTransform);
    t.dispose();
    return this;
  }

  public SwtGraphics clipPath(Path path)
  {
    if (!gc.isClipped())
    {
      org.eclipse.swt.graphics.Path p = SwtUtil.toSwtPath(path);
      gc.setClipping(p);
      p.dispose();
      return this;
    }

    Region region  = new Region();
    gc.getClipping(region);

    gc.setClipping(SwtUtil.toSwtPath(path));
    Region region2  = new Region();
    gc.getClipping(region2);

    region.intersect(region2);
    gc.setClipping(region);
    return this;
  }

  /**
   * auto free resource
   */
  @Override
  protected void finalize()
  {
    if (!gc.isDisposed()) gc.dispose();
  }

  @Override
  public Composite composite() {
    // TODO Auto-generated method stub
    return null;
  }

  @Override
  public void composite(Composite arg0) {
    // TODO Auto-generated method stub

  }

  public GC gc() { return this.gc; }
}