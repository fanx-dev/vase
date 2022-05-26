//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.vaseWindow;

import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.geom.Path2D;
import java.awt.geom.Arc2D;
import java.awt.image.BufferedImage;
import java.awt.RenderingHints;

import fan.vaseGraphics.*;

public class WtkUtil {

  private static Graphics2D scratchG = null;
  public static Graphics2D scratchG() {
    if (scratchG == null) {
      BufferedImage bufferedImage =  new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
      scratchG = bufferedImage.createGraphics();

      scratchG.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
    }
    return scratchG;
  }

  public static java.awt.Font toFont(Font f) {
    if (f == null) return null;
    int style = 0;
    if (f.bold)
      style |= java.awt.Font.BOLD;
    if (f.italic)
      style |= java.awt.Font.ITALIC;

    return new java.awt.Font(f.name, style, (int) f.size);
  }

  public static java.awt.Color toAwtColor(Color ca) {
    return new java.awt.Color((int) ca.argb, true);
  }

  static public AffineTransform toAwtTransform(Transform2D trans) {
    return new AffineTransform(
       (float)trans.a,
       (float)trans.b,
       (float)trans.c,
       (float)trans.d,
       (float)trans.e,
       (float)trans.f);
  }

  static public Transform2D toTransform(AffineTransform trans) {
    double[] elem = new double[6];
    trans.getMatrix(elem);
    Transform2D t = Transform2D.make(elem[0], elem[1], elem[2], elem[3], elem[4], elem[5]);
    return t;
  }

  static public Path2D toAwtPath(fan.vaseGraphics.GraphicsPath path) {
    int size = (int) path.steps().size();
    Path2D swtPath = new Path2D.Float();
    for (int i = 0; i < size; ++i) {
      PathStep step = (PathStep) path.steps().get(i);

      if (step instanceof PathMoveTo) {
        PathMoveTo s = (PathMoveTo) step;
        swtPath.moveTo((float) s.x, (float) s.y);
      } else if (step instanceof PathLineTo) {
        PathLineTo s = (PathLineTo) step;
        swtPath.lineTo((float) s.x, (float) s.y);
      } else if (step instanceof PathQuadTo) {
        PathQuadTo s = (PathQuadTo) step;
        swtPath.quadTo((float) s.cx, (float) s.cy, (float) s.x,
            (float) s.y);
      } else if (step instanceof PathCubicTo) {
        PathCubicTo s = (PathCubicTo) step;
        swtPath.curveTo((float) s.cx1, (float) s.cy1, (float) s.cx2,
            (float) s.cy2, (float) s.x, (float) s.y);
      } else if (step instanceof PathClose) {
        swtPath.closePath();
      } else if (step instanceof PathArc) {
        PathArc s = (PathArc) step;
        Arc2D arc = new Arc2D.Float((float)(s.cx-s.radius), 
          (float)(s.cy-s.radius), (float)(s.radius+s.radius), (float)(s.radius+s.radius),
           (float)s.startAngle, (float)s.arcAngle, Arc2D.OPEN);
        swtPath.append(arc, false);
      } else {
        throw fan.sys.Err.make("unreachable");
      }
    }
    return swtPath;
  }

  static java.awt.AlphaComposite toAwtComposite(fan.vaseGraphics.Composite com, float alpha) {
    int rule = 0;
    if (com == null) {
      return null;
    }
    if (com == fan.vaseGraphics.Composite.srcAtop) {
      rule = java.awt.AlphaComposite.SRC_ATOP;
    } else if (com == fan.vaseGraphics.Composite.srcIn) {
      rule = java.awt.AlphaComposite.SRC_IN;
    } else if (com == fan.vaseGraphics.Composite.srcOut) {
      rule = java.awt.AlphaComposite.SRC_OUT;
    } else if (com == fan.vaseGraphics.Composite.srcOver) {
      rule = java.awt.AlphaComposite.SRC_OVER;
    } else if (com == fan.vaseGraphics.Composite.dstAtop) {
      rule = java.awt.AlphaComposite.DST_ATOP;
    } else if (com == fan.vaseGraphics.Composite.dstIn) {
      rule = java.awt.AlphaComposite.DST_IN;
    } else if (com == fan.vaseGraphics.Composite.dstOut) {
      rule = java.awt.AlphaComposite.DST_OUT;
    } else if (com == fan.vaseGraphics.Composite.dstOver) {
      rule = java.awt.AlphaComposite.DST_OVER;
    } else if (com == fan.vaseGraphics.Composite.lighter) {
      return null;
    } else if (com == fan.vaseGraphics.Composite.copy) {
      rule = java.awt.AlphaComposite.SRC;
    } else if (com == fan.vaseGraphics.Composite.xor) {
      rule = java.awt.AlphaComposite.XOR;
    } else if (com == fan.vaseGraphics.Composite.clear) {
      rule = java.awt.AlphaComposite.CLEAR;
    } else {
      return null;
    }

    return java.awt.AlphaComposite.getInstance(rule, alpha);
  }

  static BufferedImage toAwtImage(Image image) {
    // TODO
    return null;
  }
}