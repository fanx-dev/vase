//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.gfx2Imp;

import fan.array.Array;
import fan.gfx.Point;

public class GfxUtil {
	public static float[] toFloats(fan.sys.List points) {
		int size = (int) points.size() * 2;
		float[] a = new float[size];
		for (int i = 0; i < size; i += 2) {
			Point p = (Point) points.get(i / 2);
			a[i] = (float) p.x;
			a[i + 1] = (float) p.y;
		}
		return a;
	}

	public static int[] toIntsX(fan.sys.List points) {
		int size = (int) points.size();
		int[] a = new int[size];
		for (int i = 0; i < size; i++) {
			Point p = (Point) points.get(i);
			a[i] = (int) p.x;
		}
		return a;
	}

	public static int[] toIntsY(fan.sys.List points) {
		int size = (int) points.size();
		int[] a = new int[size];
		for (int i = 0; i < size; i++) {
			Point p = (Point) points.get(i);
			a[i] = (int) p.y;
		}
		return a;
	}

	public static int[] arrayToInts(Array points, boolean isX) {
		int size = (int) points.size();
		int[] a = new int[size / 2];
		int i = isX ? 0 : 1;
		for (; i < size; i += 2) {
			a[i / 2] = (int) points.getInt(i);
		}
		return a;
	}

	public static float[] intsToFloats(int[] a) {
		float[] b = new float[a.length];
		for (int i = 0; i < a.length; ++i) {
			b[i] = a[i];
		}
		return b;
	}
}
