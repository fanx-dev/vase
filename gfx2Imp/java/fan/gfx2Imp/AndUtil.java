//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.gfx2Imp;

import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.graphics.Typeface;
import fan.array.Array;
import fan.fan3dMath.Transform2D;
import fan.gfx.Font;
import fan.gfx.Image;
import fan.gfx.Point;
import fan.gfx2.Image2;
import fan.gfx2.Path;
import fan.gfx2.PathClose;
import fan.gfx2.PathCubicTo;
import fan.gfx2.PathLineTo;
import fan.gfx2.PathMoveTo;
import fan.gfx2.PathQuadTo;
import fan.gfx2.PathStep;
import fan.sys.List;

public class AndUtil {

  static public android.graphics.Matrix toAndTransform(Transform2D trans) {
    Matrix m = new Matrix();
    float[] values = new float[9];

    int k = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 2; j++) {
        values[k] = (float) trans.get(i, j);
        k++;
      }
    }
    m.setValues(values);
    return m;
  }

  static public Transform2D toTransform(android.graphics.Matrix trans) {
    float[] elem = new float[6];
    trans.getValues(elem);
    Transform2D t = Transform2D.make();
    t.set(0,0, elem[0]);
    t.set(0,1, elem[1]);
    t.set(1,0, elem[2]);
    t.set(1,1, elem[3]);
    t.set(2,0, elem[4]);
    t.set(2,1, elem[5]);
    return t;
  }

  static public Bitmap toAndImage(Image2 image) {
    return ((AndImage2)image).getImage();
  }

  static public Bitmap toAndImage(Image image) {
    return null;
  }

  static public android.graphics.Path toAndPath(Path path) {
    int size = (int) path.steps().size();
    android.graphics.Path andPath = new android.graphics.Path();
    for (int i = 0; i < size; ++i) {
      PathStep step = (PathStep) path.steps().get(i);

      if (step instanceof PathMoveTo) {
        PathMoveTo s = (PathMoveTo) step;
        andPath.moveTo((float) s.x, (float) s.y);
      } else if (step instanceof PathLineTo) {
        PathLineTo s = (PathLineTo) step;
        andPath.lineTo((float) s.x, (float) s.y);
      } else if (step instanceof PathQuadTo) {
        PathQuadTo s = (PathQuadTo) step;
        andPath.quadTo((float) s.cx, (float) s.cy, (float) s.x,
            (float) s.y);
      } else if (step instanceof PathCubicTo) {
        PathCubicTo s = (PathCubicTo) step;
        andPath.cubicTo((float) s.cx1, (float) s.cy1, (float) s.cx2,
            (float) s.cy2, (float) s.x, (float) s.y);
      } else if (step instanceof PathClose) {
        andPath.close();
      } else {
        throw fan.sys.Err.make("unreachable");
      }
    }
    return andPath;
  }
  static public Typeface toAndFont(Font f) {
    if (f == null) return null;
    int style = 0;
    if (f.bold)
      style |= Typeface.BOLD;
    if (f.italic)
      style |= Typeface.ITALIC;

    Typeface typeface = Typeface.create(f.name, style);
    return typeface;
  }
  static public android.graphics.Path palygonToPath(List points) {
    android.graphics.Path andPath = new android.graphics.Path();
    int size = (int) points.size() * 2;
    Point fp = (Point)points.get(0);
    andPath.moveTo(fp.x, fp.y);
    for (int i = 1; i < size; i++) {
      Point p = (Point) points.get(i);
      andPath.lineTo(p.x, p.y);
    }
    return andPath;
  }
  static public android.graphics.Path palygonToPath(Array points) {
    android.graphics.Path andPath = new android.graphics.Path();
    int size = (int) points.size();
    float fx = points.getInt(0);
    float fy = points.getInt(1);
    andPath.moveTo(fx, fy);
    for (int i = 2; i < size; i+=2) {
      float x = points.getInt(i);
      float y = points.getInt(i+1);
      andPath.lineTo(x, y);
    }
    return andPath;
  }

}