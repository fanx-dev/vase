//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.vaseAndroid;

import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.graphics.Typeface;
import fan.vaseGraphics.*;
import fan.sys.List;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.graphics.RectF;
import android.content.Context;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class AndUtil {

  static public android.graphics.Matrix toAndTransform(Transform2D trans) {
    Matrix m = new Matrix();
    float[] values = new float[9];

    values[0] = (float)trans.a;
    values[1] = (float)trans.c;
    values[2] = (float)trans.e;
    values[3] = (float)trans.b;
    values[4] = (float)trans.d;
    values[5] = (float)trans.f;
    values[6] = 0;
    values[7] = 0;
    values[8] = 1;

    m.setValues(values);
    return m;
  }

  static public Transform2D toTransform(android.graphics.Matrix trans) {
    float[] elem = new float[9];
    trans.getValues(elem);
    Transform2D t = Transform2D.make(elem[0], elem[3], elem[1], elem[4], elem[2], elem[5]);
    return t;
  }

  static public Bitmap toAndImage(Image image) {
    if (image instanceof AndImage)
    {
      return ((AndImage)image).getImage();
    }
    // else if (image instanceof AndConstImage)
    // {
    //   return ((AndConstImage)image).getImage();
    // }
    return null;
  }

  static public android.graphics.Path toAndPath(GraphicsPath path) {
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
      } else if (step instanceof PathArc) {
        PathArc s = (PathArc) step;
        RectF rect = new RectF((float)(s.cx-s.radius), (float)(s.cy-s.radius), (float)(s.cx+s.radius), (float)(s.cy+s.radius));
        andPath.addArc(rect, (float)s.startAngle, (float)s.arcAngle);
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
  static public android.graphics.Path palygonToPath(PointArray points) {
    android.graphics.Path andPath = new android.graphics.Path();
    int size = (int) points.size();
    float fx = points.getX(0);
    float fy = points.getY(0);
    andPath.moveTo(fx, fy);
    for (int i = 1; i < size; i++) {
      float x = points.getX(i);
      float y = points.getY(i);
      andPath.lineTo(x, y);
    }
    return andPath;
  }

  static PorterDuffXfermode toAndComposite(fan.vaseGraphics.Composite com) {
    if (com == null) return null;
    android.graphics.PorterDuff.Mode rule = android.graphics.PorterDuff.Mode.SRC;
    if (com == fan.vaseGraphics.Composite.srcAtop) {
      rule = android.graphics.PorterDuff.Mode.SRC_ATOP;
    } else if (com == fan.vaseGraphics.Composite.srcIn) {
      rule = android.graphics.PorterDuff.Mode.SRC_IN;
    } else if (com == fan.vaseGraphics.Composite.srcOut) {
      rule = android.graphics.PorterDuff.Mode.SRC_OUT;
    } else if (com == fan.vaseGraphics.Composite.srcOver) {
      rule = android.graphics.PorterDuff.Mode.SRC_OVER;
    } else if (com == fan.vaseGraphics.Composite.dstAtop) {
      rule = android.graphics.PorterDuff.Mode.DST_ATOP;
    } else if (com == fan.vaseGraphics.Composite.dstIn) {
      rule = android.graphics.PorterDuff.Mode.DST_IN;
    } else if (com == fan.vaseGraphics.Composite.dstOut) {
      rule = android.graphics.PorterDuff.Mode.DST_OUT;
    } else if (com == fan.vaseGraphics.Composite.dstOver) {
      rule = android.graphics.PorterDuff.Mode.DST_OVER;
    } else if (com == fan.vaseGraphics.Composite.lighter) {
      rule = android.graphics.PorterDuff.Mode.LIGHTEN;
    } else if (com == fan.vaseGraphics.Composite.copy) {
      rule = android.graphics.PorterDuff.Mode.SRC;
    } else if (com == fan.vaseGraphics.Composite.xor) {
      rule = android.graphics.PorterDuff.Mode.XOR;
    } else if (com == fan.vaseGraphics.Composite.clear) {
      rule = android.graphics.PorterDuff.Mode.CLEAR;
    } else {
      return null;
    }

    return new PorterDuffXfermode(rule);
  }

  public static String cacheDir = "/tmp";

  public static String uriToPath(fan.std.Uri uri) {
    if (uri.scheme() == null) {
      return ((fan.std.File) uri.toFile()).osPath();
    }
    else if (uri.scheme().equals("file")) {
      return uri.pathStr();
    }
    else if (uri.scheme().equals("fan")) {

      fan.std.File srcFile = ((fan.std.File) uri.get());
      String osPath = srcFile.osPath();
      if (osPath != null) return osPath;

      fan.std.File dstFile = fan.std.File.os(cacheDir+"/res/"+uri.pathStr());
      fan.std.Map op = fan.std.Map.make();
      op.set("overwrite", false);
      srcFile.copyTo(dstFile, op);
      return dstFile.osPath();
    }
    return uri.toStr();
  }

  public static String copyAsset(Context context, String name) {
    BufferedInputStream in = null;
    BufferedOutputStream ou = null;
    String dst = cacheDir+"/" + name;
    File dstFile = new File(dst);
    if (dstFile.exists()) return dst;
    
    try {
      in = new BufferedInputStream(context.getAssets().open(name));
      ou = new BufferedOutputStream(new FileOutputStream(dst));
      byte[] buffer = new byte[8192];
      int read = 0;
      while ((read = in.read(buffer)) != -1) {
        ou.write(buffer, 0, read);
      }
    }
    catch (IOException e) {
      return null;
    }
    finally {
      if (in != null) {
        try {
          in.close();
        } catch (Exception e) {
        }
      }

      if (ou != null) {
        try {
          ou.close();
        } catch (Exception e) {
        }
      }
    }
    return dst;
  }
}