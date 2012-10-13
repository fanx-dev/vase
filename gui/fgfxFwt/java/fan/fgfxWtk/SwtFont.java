package fan.fgfxWtk;

import fan.sys.Func;

import org.eclipse.swt.graphics.GC;

import fan.fgfx2d.*;

public class SwtFont extends Font {

  private org.eclipse.swt.graphics.Font nfont = null;
  private org.eclipse.swt.graphics.FontMetrics fontMetrics = null;

  public static Font makeAwtFont(Func func)
  {
    Font f = new SwtFont();
    func.enterCtor(f);
    func.call(f);
    func.exitCtor();
    return f;
  }

  public org.eclipse.swt.graphics.Font getNFont() {
    if (nfont == null) {
      nfont = SwtUtil.toFont(this);
    }
    return nfont;
  }

  private GC scratchGC()
  {
    GC gc = SwtUtil.scratchG();
    gc.setFont(nfont);
    return gc;
  }

  public org.eclipse.swt.graphics.FontMetrics getFontMetrics() {
    if (fontMetrics == null) {
      fontMetrics = scratchGC().getFontMetrics();
    }
    return fontMetrics;
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
    return scratchGC().textExtent(s).x;
  }

}