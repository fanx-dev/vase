package fan.gfx2Imp;

import android.graphics.Paint;
import android.graphics.Typeface;
import fan.gfx.Font;
import fan.gfx.GfxEnv;
import fan.gfx.Image;
import fan.gfx.Size;
import fan.sys.Func;
import fan.sys.UnsupportedErr;

public class AndGfxEnv extends GfxEnv{

  static final AndGfxEnv instance = new AndGfxEnv();
  private AndGfxEnv() {}

  private Paint p = new Paint();

  @Override
  public long fontAscent(Font f) {
    Typeface tf = AndUtil.toAndFont(f);
    p.setTypeface(tf);
    return (long) p.ascent();
  }

  @Override
  public long fontDescent(Font f) {
    Typeface tf = AndUtil.toAndFont(f);
    p.setTypeface(tf);
    return (long) p.descent();
  }

  @Override
  public long fontHeight(Font f) {
    Typeface tf = AndUtil.toAndFont(f);
    p.setTypeface(tf);

    Paint.FontMetricsInt metrics = p.getFontMetricsInt();
    return metrics.bottom - metrics.top;
  }

  @Override
  public long fontLeading(Font f) {
    Typeface tf = AndUtil.toAndFont(f);
    p.setTypeface(tf);

    Paint.FontMetricsInt metrics = p.getFontMetricsInt();
    return metrics.leading;
  }

  @Override
  public long fontWidth(Font f, String s) {
    Typeface tf = AndUtil.toAndFont(f);
    p.setTypeface(tf);
    return (long) p.measureText(s);
  }

  @Override
  public Image imagePaint(Size size, Func arg1) {
    throw UnsupportedErr.make();
  }

  @Override
  public Image imageResize(Image arg0, Size arg1) {
    throw UnsupportedErr.make();
  }

  @Override
  public Size imageSize(Image arg0) {
    throw UnsupportedErr.make();
  }
}