//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.gfx2Imp;

import java.awt.geom.AffineTransform;
import java.awt.geom.Path2D;
import java.awt.image.BufferedImage;

import fan.fan3dMath.Transform2D;
import fan.gfx.Font;
import fan.gfx.Image;
import fan.gfx2.PathClose;
import fan.gfx2.PathCubicTo;
import fan.gfx2.PathLineTo;
import fan.gfx2.PathMoveTo;
import fan.gfx2.PathQuadTo;
import fan.gfx2.PathStep;

public class AwtUtil {
	public static java.awt.Font toFont(Font f) {
		int style = 0;
		if (f.bold)
			style |= java.awt.Font.BOLD;
		if (f.italic)
			style |= java.awt.Font.ITALIC;

		return new java.awt.Font(f.name, style, (int) f.size);
	}

	static public AffineTransform toAwtTransform(Transform2D trans) {
		return new AffineTransform((float) trans.get(0, 0), (float) trans.get(
				1, 0), (float) trans.get(0, 1), (float) trans.get(1, 1),
				(float) trans.get(2, 0), (float) trans.get(2, 1));
	}

	static public Path2D toAwtPath(fan.gfx2.Path path) {
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

	static BufferedImage toAwtImage(Image image) {
		// TODO
		return null;
	}
}
