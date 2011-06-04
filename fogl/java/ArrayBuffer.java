//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;

import fan.sys.*;

import java.nio.*;


class ArrayBuffer extends FanObj
{
  private java.nio.Buffer data;

  public static ArrayBuffer makeFloat(List list)
  {
    ArrayBuffer buffer = new ArrayBuffer();
    makeFloat$(buffer, list);
    return buffer;
  }
  public static void makeFloat$(ArrayBuffer self, List list)
  {
    self.data = FloatBuffer.wrap(toFloatArray(list));
  }

  public static ArrayBuffer makeDouble(List list)
  {
    ArrayBuffer buffer = new ArrayBuffer();
    makeDouble$(buffer, list);
    return buffer;
  }
  public static void makeDouble$(ArrayBuffer self, List list)
  {
    self.data = DoubleBuffer.wrap(toDoubleArray(list));
  }

  public static ArrayBuffer makeInt(List list)
  {
    ArrayBuffer buffer = new ArrayBuffer();
    makeInt$(buffer, list);
    return buffer;
  }
  public static void makeInt$(ArrayBuffer self, List list)
  {
    self.data = IntBuffer.wrap(toIntArray(list));
  }

  public static ArrayBuffer makeShort(List list)
  {
    ArrayBuffer buffer = new ArrayBuffer();
    makeShort$(buffer, list);
    return buffer;
  }
  public static void makeShort$(ArrayBuffer self, List list)
  {
    self.data = ShortBuffer.wrap(toShortArray(list));
  }

  public static ArrayBuffer makeByte(List list)
  {
    ArrayBuffer buffer = new ArrayBuffer();
    makeByte$(buffer, list);
    return buffer;
  }
  public static void makeByte$(ArrayBuffer self, List list)
  {
    self.data = ByteBuffer.wrap(toByteArray(list));
  }

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

  // boiler plate for reflection
  public Type typeof()
  {
    if (type == null) type = Type.find("fogl::ArrayBuffer");
    return type;
  }
  private static Type type;

  // methods
  public java.nio.Buffer getData() { return data; }

//////////////////////////////////////////////////////////////////////////
// util
//////////////////////////////////////////////////////////////////////////

  static int[] toIntArray(fan.sys.List list)
  {
    int size = (int)list.size();
    int[] a = new int[size];
    for (int i=0; i<size; ++i)
    {
      a[i] = (Integer)list.get(i);
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
      a[i] = (Short)list.get(i);
    }
    return a;
  }

  static float[] toFloatArray(fan.sys.List list)
  {
    int size = (int)list.size();
    float[] a = new float[size];
    for (int i=0; i<size; ++i)
    {
      a[i] = (Float)list.get(i);
    }
    return a;
  }

  static double[] toDoubleArray(fan.sys.List list)
  {
    int size = (int)list.size();
    double[] a = new double[size];
    for (int i=0; i<size; ++i)
    {
      a[i] = (Double)list.get(i);
    }
    return a;
  }

  static byte[] toByteArray(fan.sys.List list)
  {
    int size = (int)list.size();
    byte[] a = new byte[size];
    for (int i=0; i<size; ++i)
    {
      a[i] = (Byte)list.get(i);
    }
    return a;
  }
}