//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.fgfxFwt;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Transform;
import org.eclipse.swt.widgets.Display;

import fan.fgfxMath.Transform2D;
import fan.fgfx2d.*;

public class SwtUtil {

  static Display getDisplay() {
    return Display.getCurrent() == null ? new Display() : Display.getCurrent(); // SWT display
  }

  private static GC scratchGC = null;
  public static GC scratchG() {
    if (scratchGC == null) scratchGC = new GC(getDisplay());
    return scratchGC;
  }

  public static org.eclipse.swt.graphics.Font toFont(Font f) {
    if (f == null) return null;
    int style = SWT.NORMAL;
    if (f.bold) style |= SWT.BOLD;
    if (f.italic) style |= SWT.ITALIC;
    return new org.eclipse.swt.graphics.Font(getDisplay(), f.name, (int)f.size, style);
  }

  static public Transform toSwtTransform(Transform2D trans)
  {
    return new Transform(getDisplay(),
       (float)trans.get(0,0),
       (float)trans.get(0,1),
       (float)trans.get(1,0),
       (float)trans.get(1,1),
       (float)trans.get(2,0),
       (float)trans.get(2,1)
       );
  }

  static public Transform2D toTransform(Transform trans) {
    float[] elem = new float[6];
    trans.getElements(elem);
    Transform2D t = Transform2D.make();
    t.set(0,0, elem[0]);
    t.set(0,1, elem[1]);
    t.set(1,0, elem[2]);
    t.set(1,1, elem[3]);
    t.set(2,0, elem[4]);
    t.set(2,1, elem[5]);
    return t;
  }

  static public org.eclipse.swt.graphics.Path toSwtPath(Path path)
  {
    int size = (int)path.steps().size();
    org.eclipse.swt.graphics.Path swtPath = new org.eclipse.swt.graphics.Path(getDisplay());
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
      else if (step instanceof PathClose)
      {
        swtPath.close();
      }
      else
      {
        throw fan.sys.Err.make("unreachable");
      }
    }
    return swtPath;
  }

  static java.awt.AlphaComposite toAwtComposite(fan.fgfx2d.Composite com, float alpha) {
    int rule = 0;
    if (com == fan.fgfx2d.Composite.srcAtop) {
      rule = java.awt.AlphaComposite.SRC_ATOP;
    } else if (com == fan.fgfx2d.Composite.srcIn) {
      rule = java.awt.AlphaComposite.SRC_IN;
    } else if (com == fan.fgfx2d.Composite.srcOut) {
      rule = java.awt.AlphaComposite.SRC_OUT;
    } else if (com == fan.fgfx2d.Composite.dstAtop) {
      rule = java.awt.AlphaComposite.DST_ATOP;
    } else if (com == fan.fgfx2d.Composite.dstIn) {
      rule = java.awt.AlphaComposite.DST_IN;
    } else if (com == fan.fgfx2d.Composite.dstOut) {
      rule = java.awt.AlphaComposite.DST_OUT;
    } else if (com == fan.fgfx2d.Composite.dstOver) {
      rule = java.awt.AlphaComposite.DST_OVER;
    } else if (com == fan.fgfx2d.Composite.lighter) {
      return null;
    } else if (com == fan.fgfx2d.Composite.copy) {
      rule = java.awt.AlphaComposite.SRC;
    } else if (com == fan.fgfx2d.Composite.xor) {
      rule = java.awt.AlphaComposite.XOR;
    } else if (com == fan.fgfx2d.Composite.clear) {
      rule = java.awt.AlphaComposite.CLEAR;
    } else {
      return null;
    }

    return java.awt.AlphaComposite.getInstance(rule, alpha);
  }

  static org.eclipse.swt.graphics.Color toSwtColor(Color c)
  {
    int argb = (int)(c).argb;
    return new org.eclipse.swt.graphics.Color(SwtUtil.getDisplay(), (argb >> 16) & 0xff, (argb >> 8) & 0xff, argb & 0xff);
  }

  static org.eclipse.swt.graphics.Image toSwtImage(Image image) {
    org.eclipse.swt.graphics.Image img = null;
    if (image instanceof SwtImage) {
      img = ((SwtImage) image).getImage();
    } else if (image instanceof SwtConstImage) {
      img = ((SwtConstImage) image).getImage();
    }
    return img;
  }
}