//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.fgfxWtk;

import java.awt.AlphaComposite;
import java.awt.BasicStroke;
import java.awt.Composite;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.TexturePaint;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.util.Stack;

import fan.fgfxMath.Transform2D;
import fan.fgfx2d.*;
import fan.sys.ArgErr;
import fan.sys.FanObj;

public class AwtGraphics implements Graphics {
  Graphics2D gc;

  Pen pen = Pen.defVal;
  Brush brush = Color.black;
  Font font;
  int alpha = 255;
  fan.fgfx2d.Composite composite;

  Stack<State> stack = new Stack<State>();

  public AwtGraphics(Graphics2D gc)
  {
    this.gc = gc;
  }

  @Override
  public long alpha() {
    return alpha;
  }

  @Override
  public void alpha(long a) {
    Composite c = AlphaComposite.getInstance(AlphaComposite.SRC_OVER,
        a / 255f);
    gc.setComposite(c);
  }

  @Override
  public boolean antialias() {
    Object r = gc.getRenderingHint(RenderingHints.KEY_ANTIALIASING);
    if (RenderingHints.VALUE_ANTIALIAS_ON == r)
      return true;
    else
      return false;
  }

  @Override
  public void antialias(boolean a) {
    Object h = a ? RenderingHints.VALUE_ANTIALIAS_ON
        : RenderingHints.VALUE_ANTIALIAS_OFF;
    gc.setRenderingHint(RenderingHints.KEY_ANTIALIASING, h);
  }

  @Override
  public Brush brush() {
    return brush;
  }

  @Override
  public void brush(Brush brush) {
    this.brush = brush;
    if (brush instanceof Color) {
      Color ca = (Color) brush;
      java.awt.Color color = toAwtColor(ca);
      gc.setColor(color);
      gc.setBackground(color);
    } else if (brush instanceof Gradient) {
      // can't really map SWT model to CSS model well
      GradientPaint p = pattern((Gradient) brush, 0, 0, 100, 100);
      gc.setPaint(p);
    } else if (brush instanceof Pattern) {
      Pattern p = (Pattern) brush;
      BufferedImage im = AwtUtil.toAwtImage(p.image);
      TexturePaint tp = new TexturePaint(im, new Rectangle(im.getWidth(),
          im.getHeight()));
      gc.setPaint(tp);
    } else {
      throw ArgErr
          .make("Unsupported brush type: " + FanObj.typeof(brush));
    }
  }

  private static java.awt.Color toAwtColor(Color ca) {
    return new java.awt.Color((int) ca.argb, true);
  }

  private static GradientPaint pattern(Gradient g, float vx, float vy, float vw,
      float vh) {
    // only support two gradient stops
    GradientStop s1 = (GradientStop) g.stops.get(0);
    GradientStop s2 = (GradientStop) g.stops.get(-1L);
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
    if (x1Percent)
      x1 = vx + vw * g.x1 / 100f;
    if (y1Percent)
      y1 = vy + vh * g.y1 / 100f;
    if (x2Percent)
      x2 = vx + vw * g.x2 / 100f;
    if (y2Percent)
      y2 = vy + vh * g.y2 / 100f;

    return new GradientPaint(x1, y1, toAwtColor(s1.color), x2, y2,
        toAwtColor(s2.color));
  }

  @Override
  public Graphics clip(Rect r) {
    gc.setClip((int) r.x, (int) r.y, (int) r.w, (int) r.h);
    return this;
  }

  @Override
  public Rect clipBounds() {
    Rectangle r = gc.getClipBounds();
    return Rect.make(r.x, r.y, r.width, r.height);
  }

  @Override
  public void dispose() {
    gc.dispose();
  }

  @Override
  public Graphics drawArc(long x, long y, long w, long h, long s, long a) {
    gc.drawArc((int) x, (int) y, (int) w, (int) h, (int) s, (int) a);
    return this;
  }

  @Override
  public Graphics drawLine(long x1, long y1, long x2, long y2) {
    gc.drawLine((int) x1, (int) y1, (int) x2, (int) y2);
    return this;
  }

  @Override
  public Graphics drawOval(long x, long y, long w, long h) {
    gc.drawOval((int) x, (int) y, (int) w, (int) h);
    return this;
  }

  @Override
  public Graphics drawPolygon(PointArray list) {
    AwtPointArray pa = (AwtPointArray)list;
    gc.drawPolygon(pa.xa, pa.ya, pa.xa.length);
    return this;
  }

  @Override
  public Graphics drawPolyline(PointArray list) {
    AwtPointArray pa = (AwtPointArray)list;
    gc.drawPolyline(pa.xa, pa.ya, pa.xa.length);
    return this;
  }

  @Override
  public Graphics drawRect(long x, long y, long w, long h) {
    gc.drawRect((int) x, (int) y, (int) w, (int) h);
    return this;
  }

  @Override
  public Graphics drawRoundRect(long x, long y, long w, long h, long wArc,
      long hArc) {
    gc.drawRoundRect((int) x, (int) y, (int) w, (int) h, (int) wArc,
        (int) hArc);
    return this;
  }

  @Override
  public Graphics drawText(String str, long x, long y) {
    gc.drawString(str, (int) x, (int) y);
    return this;
  }

  @Override
  public Graphics fillArc(long x, long y, long w, long h, long s, long a) {
    gc.fillArc((int) x, (int) y, (int) w, (int) h, (int) s, (int) a);
    return this;
  }

  @Override
  public Graphics fillOval(long x, long y, long w, long h) {
    gc.fillOval((int) x, (int) y, (int) w, (int) h);
    return this;
  }

  @Override
  public Graphics fillPolygon(PointArray list) {
    AwtPointArray pa = (AwtPointArray)list;
    gc.fillPolygon(pa.xa, pa.ya, pa.xa.length);
    return this;
  }

  @Override
  public Graphics fillRect(long x, long y, long w, long h) {
    gc.fillRect((int) x, (int) y, (int) w, (int) h);
    return this;
  }

  @Override
  public Graphics fillRoundRect(long x, long y, long w, long h, long wArc,
      long hArc) {
    gc.fillRoundRect((int) x, (int) y, (int) w, (int) h, (int) wArc,
        (int) hArc);
    return this;
  }

  @Override
  public Font font() {
    return font;
  }
  @Override
  public void font(Font f) {
    this.font = f;
    java.awt.Font font = AwtUtil.toFont(f);
    gc.setFont(font);
  }

  @Override
  public Pen pen() {
    return pen;
  }

  @Override
  public void pen(Pen pen) {
    this.pen = pen;
    float width = pen.width;
    int cap = penCap(pen.cap);
    int join = penJoin(pen.join);
    float[] dash = pen.dash != null ? GfxUtil.intsToFloats(pen.dash.toInts())
        : null;

    BasicStroke stroke;
    if (dash != null)
      stroke = new BasicStroke(width, cap, join, 1, dash, 0);
    else
      stroke = new BasicStroke(width, cap, join);

    gc.setStroke(stroke);
  }

  private static int penCap(long cap) {
    if (cap == Pen.capSquare)
      return BasicStroke.CAP_SQUARE;
    if (cap == Pen.capButt)
      return BasicStroke.CAP_BUTT;
    if (cap == Pen.capRound)
      return BasicStroke.CAP_ROUND;
    throw new IllegalStateException("Invalid pen.cap " + cap);
  }

  private static int penJoin(long join) {
    if (join == Pen.joinMiter)
      return BasicStroke.JOIN_MITER;
    if (join == Pen.joinBevel)
      return BasicStroke.JOIN_BEVEL;
    if (join == Pen.joinRound)
      return BasicStroke.JOIN_ROUND;
    throw new IllegalStateException("Invalid pen.join " + join);
  }

  @Override
  public Graphics clipPath(Path path) {
    gc.clip(AwtUtil.toAwtPath(path));
    return this;
  }

  @Override
  public Graphics copyImage(fan.fgfx2d.Image img2, Rect src, Rect dest) {
    BufferedImage img = null;
    if (img2 instanceof AwtImage) {
      img = ((AwtImage) img2).getImage();
    } else if (img2 instanceof AwtConstImage) {
      img = ((AwtConstImage) img2).getImage();
    }
    gc.drawImage(img, (int) dest.x, (int) dest.y, (int) dest.x
        + (int) dest.w, (int) dest.y + (int) dest.h, (int) src.x,
        (int) src.y, (int) src.x + (int) src.w, (int) src.y
            + (int) src.h, null);
    return this;
  }

  @Override
  public Graphics drawImage(fan.fgfx2d.Image img2, long x, long y) {
    BufferedImage img = null;
    if (img2 instanceof AwtImage) {
      img = ((AwtImage) img2).getImage();
    } else if (img2 instanceof AwtConstImage) {
      img = ((AwtConstImage) img2).getImage();
    }
    gc.drawImage(img, (int) x, (int) y, null);
    return this;
  }

  @Override
  public Graphics drawPath(Path path) {
    gc.draw(AwtUtil.toAwtPath(path));
    return this;
  }

  @Override
  public Graphics fillPath(Path path) {
    gc.fill(AwtUtil.toAwtPath(path));
    return this;
  }

  @Override
  public void transform(Transform2D trans) {
    gc.setTransform(AwtUtil.toAwtTransform(trans));
  }

  @Override
  public Transform2D transform() {
    return AwtUtil.toTransform(gc.getTransform());
  }

  public void push() {
    State s = new State();
    s.pen = pen;
    s.brush = brush;
    s.font = font;
    s.antialias = this.antialias();
    s.alpha = alpha;
    s.transform = gc.getTransform();
    s.clip = gc.getClip();
    stack.push(s);
  }

  public void pop() {
    State s = (State) stack.pop();
    alpha = s.alpha;
    pen(s.pen);
    brush(s.brush);
    font(s.font);
    this.antialias(s.antialias);
    gc.setTransform(s.transform);
    gc.clip(s.clip);
  }

  // ////////////////////////////////////////////////////////////////////////
  // Util
  // ////////////////////////////////////////////////////////////////////////

  static class State {
    Pen pen;
    Brush brush;
    Font font;
    boolean antialias;
    int alpha;
    AffineTransform transform;
    Shape clip;
  }

  @Override
  public fan.fgfx2d.Composite composite() {
    return composite;
  }

  @Override
  public void composite(fan.fgfx2d.Composite com) {
    java.awt.AlphaComposite ncom = AwtUtil.toAwtComposite(com, (float)(this.alpha/255.0));
    if (ncom == null) return;
    this.gc.setComposite(ncom);
    composite = com;
  }
}