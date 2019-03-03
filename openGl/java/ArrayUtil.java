//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fanvasOpenGl;

import fan.sys.*;

class ArrayUtil
{
  public static Object listToArray(List list, NumType type)
  {
    if (type == NumType.tByte)
    {
      return toByteArray(list);
    }
    else if (type == NumType.tFloat)
    {
      return toFloatArray(list);
    }
    else if (type == NumType.tDouble)
    {
      return toDoubleArray(list);
    }
    else if(type == NumType.tInt)
    {
      return toIntArray(list);
    }
    else if(type == NumType.tShort)
    {
      return toShortArray(list);
    }
    else if(type == NumType.tLong)
    {
      return toLongArray(list);
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

  static int[] toIntArray(fan.sys.List list)
  {
    int size = (int)list.size();
    int[] a = new int[size];
    for (int i=0; i<size; ++i)
    {
      long v = (Long)list.get(i);
      a[i] = (int)v;
    }
    return a;
  }

  static long[] toLongArray(fan.sys.List list)
  {
    int size = (int)list.size();
    long[] a = new long[size];
    for (int i=0; i<size; ++i)
    {
      a[i] = (Long)list.get(i);
    }
    return a;
  }

  static short[] toShortArray(fan.sys.List list)
  {
    int size = (int)list.size();
    short[] a = new short[size];
    for (int i=0; i<size; ++i)
    {
      long v = (Long)list.get(i);
      a[i] = (short)v;
    }
    return a;
  }

  static float[] toFloatArray(fan.sys.List list)
  {
    int size = (int)list.size();
    float[] a = new float[size];
    for (int i=0; i<size; ++i)
    {
      double v = (Double)list.get(i);
      a[i] = (float)v;
    }
    return a;
  }

  static double[] toDoubleArray(fan.sys.List list)
  {
    int size = (int)list.size();
    double[] a = new double[size];
    for (int i=0; i<size; ++i)
    {
      double v = (Double)list.get(i);
      a[i] = v;
    }
    return a;
  }

  static byte[] toByteArray(fan.sys.List list)
  {
    int size = (int)list.size();
    byte[] a = new byte[size];
    for (int i=0; i<size; ++i)
    {
      long v = (Long)list.get(i);
      a[i] = (byte)v;
    }
    return a;
  }
}