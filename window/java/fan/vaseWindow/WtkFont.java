package fan.vaseWindow;

import fan.sys.Func;

import fan.vaseGraphics.*;

public class WtkFont extends Font {

  private java.awt.Font nfont = null;
  private java.awt.FontMetrics fontMetrics = null;
  private java.awt.FontMetrics fallbackMetrics = null;
  private java.awt.Font fallback = null;

  public static Font makeAwtFont(Func func)
  {
    Font f = new WtkFont();
    //func.enterCtor(f);
    func.call(f);
    //func.exitCtor();
    return f;
  }

  public java.awt.Font getNFont() {
    if (nfont == null) {
      nfont = WtkUtil.toFont(this);
    }
    return nfont;
  }

  public java.awt.Font getFallbackFont() {
    if (fallback == null) {
      Object v = fan.concurrent.Actor.locals().get("vaseWindow.font.fallback");
      String name = "Monospaced";
      if (v != null) name = (String)v;
      fallback = WtkUtil.toFont(this, name);
    }
    return fallback;
  }

  void bind(java.awt.Graphics2D g) {
    fontMetrics = g.getFontMetrics(getNFont());
    fallbackMetrics = g.getFontMetrics(getFallbackFont());
  }

  void unbind() {
    fontMetrics = null;
  }

  public java.awt.FontMetrics getFontMetrics() {
    if (fontMetrics == null) {
      fontMetrics = WtkUtil.scratchG().getFontMetrics(getNFont());
    }
    return fontMetrics;
  }

  public java.awt.FontMetrics getFallbackMetrics() {
    if (fallbackMetrics == null) {
      fallbackMetrics = WtkUtil.scratchG().getFontMetrics(getFallbackFont());
    }
    return fallbackMetrics;
  }

  @Override
  public long ascent() {
    return getFontMetrics().getAscent();
  }

  @Override
  public long descent() {
    return getFontMetrics().getDescent();
  }

  @Override
  public void dispose() {
  }

  @Override
  public long height() {
    return getFontMetrics().getHeight();
  }

  @Override
  public long leading() {
    return getFontMetrics().getLeading();
  }

  @Override
  public long width(String s) {
    int i = getNFont().canDisplayUpTo(s);
    if (i != -1) {
      return getFallbackMetrics().stringWidth(s);
    }
    return getFontMetrics().stringWidth(s);
  }

}