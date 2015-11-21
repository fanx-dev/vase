//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.fanvasWindow;

import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.geom.Path2D;
import java.awt.image.BufferedImage;

import fan.fanvasMath.Transform2D;
import fan.fanvasGraphics.*;

public class WtkUtil {

  private static Graphics2D scratchG = null;
  public static Graphics2D scratchG() {
    if (scratchG == null) {
      BufferedImage bufferedImage =  new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
      scratchG = bufferedImage.createGraphics();
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

  static public AffineTransform toAwtTransform(Transform2D trans) {
    return new AffineTransform(
       (float)trans.get(0,0),
       (float)trans.get(0,1),
       (float)trans.get(1,0),
       (float)trans.get(1,1),
       (float)trans.get(2,0),
       (float)trans.get(2,1));
  }

  static public Transform2D toTransform(AffineTransform trans) {
    double[] elem = new double[6];
    trans.getMatrix(elem);
    Transform2D t = Transform2D.make();
    t.set(0,0, elem[0]);
    t.set(0,1, elem[1]);
    t.set(1,0, elem[2]);
    t.set(1,1, elem[3]);
    t.set(2,0, elem[4]);
    t.set(2,1, elem[5]);
    return t;
  }

  static public Path2D toAwtPath(fan.fanvasGraphics.Path path) {
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
      } else {
        throw fan.sys.Err.make("unreachable");
      }
    }
    return swtPath;
  }

  static java.awt.AlphaComposite toAwtComposite(fan.fanvasGraphics.Composite com, float alpha) {
    int rule = 0;
    if (com == fan.fanvasGraphics.Composite.srcAtop) {
      rule = java.awt.AlphaComposite.SRC_ATOP;
    } else if (com == fan.fanvasGraphics.Composite.srcIn) {
      rule = java.awt.AlphaComposite.SRC_IN;
    } else if (com == fan.fanvasGraphics.Composite.srcOut) {
      rule = java.awt.AlphaComposite.SRC_OUT;
    } else if (com == fan.fanvasGraphics.Composite.dstAtop) {
      rule = java.awt.AlphaComposite.DST_ATOP;
    } else if (com == fan.fanvasGraphics.Composite.dstIn) {
      rule = java.awt.AlphaComposite.DST_IN;
    } else if (com == fan.fanvasGraphics.Composite.dstOut) {
      rule = java.awt.AlphaComposite.DST_OUT;
    } else if (com == fan.fanvasGraphics.Composite.dstOver) {
      rule = java.awt.AlphaComposite.DST_OVER;
    } else if (com == fan.fanvasGraphics.Composite.lighter) {
      return null;
    } else if (com == fan.fanvasGraphics.Composite.copy) {
      rule = java.awt.AlphaComposite.SRC;
    } else if (com == fan.fanvasGraphics.Composite.xor) {
      rule = java.awt.AlphaComposite.XOR;
    } else if (com == fan.fanvasGraphics.Composite.clear) {
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