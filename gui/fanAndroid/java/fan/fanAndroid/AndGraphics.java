//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.fanAndroid;

import java.util.Stack;

import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.Typeface;
import fan.fan2d.*;
import fan.fan3dMath.Transform2D;
import fan.sys.ArgErr;
import fan.sys.FanObj;

public class AndGraphics implements Graphics {

  Pen pen = Pen.defVal;
  Brush brush = Color.black;
  Font font;
  int alpha = 255;
  Composite composite = Composite.copy;

  Stack<State> stack = new Stack<State>();
  Canvas gc;
  Paint p = new Paint();
  public AndGraphics(Canvas c)
  {
    gc = c;
  }

  @Override
  public long alpha() {
    return alpha;
  }

  @Override
  public void alpha(long a) {
    p.setAlpha((int) a);
  }

  @Override
  public boolean antialias() {
    return p.isAntiAlias();
  }

  @Override
  public void antialias(boolean a) {
    p.setAntiAlias(a);
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
      p.setColor((int) ca.argb);
    } else if (brush instanceof Gradient) {
      Shader s = pattern((Gradient) brush, 0, 0, 100, 100);
      p.setShader(s);
    } else if (brush instanceof fan.fan2d.Pattern) {
      fan.fan2d.Pattern pattern = (fan.fan2d.Pattern) brush;
      Bitmap im = AndUtil.toAndImage(pattern.image);
      BitmapShader tp = new BitmapShader(im,
          toAndTileMode(pattern.halign),
          toAndTileMode(pattern.valign));
      p.setShader(tp);
    } else {
      throw ArgErr
          .make("Unsupported brush type: " + FanObj.typeof(brush));
    }
  }

  private static Shader.TileMode toAndTileMode(Halign h) {
    if (h == Halign.repeat)
      return Shader.TileMode.REPEAT;
    else
      return Shader.TileMode.CLAMP;
  }

  private static Shader.TileMode toAndTileMode(Valign h) {
    if (h == Valign.repeat)
      return Shader.TileMode.REPEAT;
    else
      return Shader.TileMode.CLAMP;
  }

  private static Shader pattern(Gradient g, float vx, float vy, float vw, float vh) {
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

    return new LinearGradient(x1, y1, x2, y2, (int) s1.color.argb,
        (int) s2.color.argb, Shader.TileMode.REPEAT);
  }

  @Override
  public Graphics clip(Rect r) {
    gc.clipRect(r.x, r.y, r.x + r.w, r.y + r.h);
    return this;
  }

  static android.graphics.Rect toAndRect(Rect r) {
    return new android.graphics.Rect((int) r.x, (int) r.y,
        (int) (r.x + r.w), (int) (r.y + r.h));
  }

  @Override
  public Rect clipBounds() {
    android.graphics.Rect r = gc.getClipBounds();
    return Rect.make(r.left, r.top, r.right - r.left, r.bottom - r.top);
  }

  @Override
  public void dispose() {
    // gc.dispose();
  }

  @Override
  public Graphics drawArc(long x, long y, long w, long h, long s, long a) {
    RectF r = new RectF(x, y, x + w, y + h);
    gc.drawArc(r, s, a, false, p);
    return this;
  }

  @Override
  public Graphics drawLine(long x1, long y1, long x2, long y2) {
    gc.drawLine(x1, y1, x2, y2, p);
    return this;
  }

  @Override
  public Graphics drawOval(long x, long y, long w, long h) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.STROKE);
    gc.drawOval(r, p);
    return this;
  }


  @Override
  public Graphics drawRect(long x, long y, long w, long h) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawRect(x, y, x + w, y + h, p);
    return this;
  }

  @Override
  public Graphics drawRoundRect(long x, long y, long w, long h, long wArc,
      long hArc) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.STROKE);
    gc.drawRoundRect(r, wArc/2f, hArc/2f, p);
    return this;
  }
  @Override
  public Graphics drawText(String str, long x, long y) {
    p.setStyle(Paint.Style.FILL);
    gc.drawText(str, x, y, p);
    return this;
  }

  @Override
  public Graphics fillArc(long x, long y, long w, long h, long s, long a) {
    RectF r = new RectF(x, y, x + w, y + h);
    gc.drawArc(r, s, a, true, p);
    return this;
  }

  @Override
  public Graphics fillOval(long x, long y, long w, long h) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.FILL);
    gc.drawOval(r, p);
    return this;
  }

  @Override
  public Graphics fillRect(long x, long y, long w, long h) {
    p.setStyle(Paint.Style.FILL);
    gc.drawRect(x, y, x + w, y + h, p);
    return this;
  }

  @Override
  public Graphics fillRoundRect(long x, long y, long w, long h, long wArc,
      long hArc) {
    RectF r = new RectF(x, y, x + w, y + h);
    p.setStyle(Paint.Style.FILL);
    gc.drawRoundRect(r, wArc/2f, hArc/2f, p);
    return this;
  }
  @Override
  public Font font() {
    return font;
  }
  @Override
  public void font(Font f) {
    this.font = f;
    Typeface typeface = AndUtil.toAndFont(f);
    p.setTypeface(typeface);

    //TODO: reset textSize
    if (typeface != null) p.setTextSize(f.size);
  }
  @Override
  public Pen pen() {
    return pen;
  }

  @Override
  public void pen(Pen pen) {
    this.pen = pen;
    p.setStrokeWidth(pen.width);
    p.setStrokeCap(penCap(pen.cap));
    p.setStrokeJoin(penJoin(pen.join));

    // TODO Dash mode
  }

  private static Paint.Cap penCap(long cap) {
    if (cap == Pen.capSquare)
      return Paint.Cap.SQUARE;
    if (cap == Pen.capButt)
      return Paint.Cap.BUTT;
    if (cap == Pen.capRound)
      return Paint.Cap.ROUND;
    throw new IllegalStateException("Invalid pen.cap " + cap);
  }

  private static Paint.Join penJoin(long join) {
    if (join == Pen.joinMiter)
      return Paint.Join.MITER;
    if (join == Pen.joinBevel)
      return Paint.Join.BEVEL;
    if (join == Pen.joinRound)
      return Paint.Join.ROUND;
    throw new IllegalStateException("Invalid pen.join " + join);
  }

  @Override
  public Graphics clipPath(Path path) {
    gc.clipPath(AndUtil.toAndPath(path));
    return this;
  }

  @Override
  public Graphics copyImage(Image img2, Rect src, Rect dest) {
    Bitmap img = AndUtil.toAndImage(img2);
    gc.drawBitmap(img, toAndRect(src), toAndRect(dest), p);
    return this;
  }

  @Override
  public Graphics drawImage(Image img2, long x, long y) {
    Bitmap img = AndUtil.toAndImage(img2);
    gc.drawBitmap(img, x, y, p);
    return this;
  }

  @Override
  public Graphics drawPath(Path path) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawPath(AndUtil.toAndPath(path), p);
    return this;
  }

  @Override
  public Graphics drawPolyline(PointArray a) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawPath(AndUtil.palygonToPath(a), p);
    return this;
  }
 
  @Override
  public Graphics drawPolygon(PointArray list) {
    p.setStyle(Paint.Style.STROKE);
    gc.drawPath(AndUtil.palygonToPath(list), p);
    return this;
  }
  
  @Override
  public Graphics fillPath(Path path) {
    p.setStyle(Paint.Style.FILL);
    gc.drawPath(AndUtil.toAndPath(path), p);
    return this;
  }

  @Override
  public Graphics fillPolygon(PointArray a) {
    p.setStyle(Paint.Style.FILL);
    gc.drawPath(AndUtil.palygonToPath(a), p);
    return this;
  }
  @Override
  public void transform(Transform2D trans) {
    gc.setMatrix(AndUtil.toAndTransform(trans));
  }

  @Override
  public Transform2D transform() {
    return AndUtil.toTransform(gc.getMatrix());
  }

  public void push() {
    State s = new State();
    s.pen = pen;
    s.brush = brush;
    s.font = font;
    s.antialias = this.antialias();
    s.alpha = alpha;
    s.transform = gc.getMatrix();
    s.clip = gc.getClipBounds();
    stack.push(s);
  }

  public void pop() {
    State s = (State) stack.pop();
    alpha = s.alpha;
    pen(s.pen);
    brush(s.brush);
    font(s.font);
    this.antialias(s.antialias);
    gc.setMatrix(s.transform);
    gc.clipRect(s.clip);
  }

  //////////////////////////////////////////////////////////////////////////
  // Util
  //////////////////////////////////////////////////////////////////////////

  static class State {
    Pen pen;
    Brush brush;
    Font font;
    boolean antialias;
    int alpha;
    Matrix transform;
    android.graphics.Rect clip;
  }

  @Override
  public Composite composite() {
    return composite;
  }

  @Override
  public void composite(Composite cmp) {
    // TODO Auto-generated method stub
    this.composite = cmp;
  }

}