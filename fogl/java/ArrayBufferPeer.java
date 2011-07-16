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

import org.lwjgl.BufferUtils;


class ArrayBufferPeer
{
  private java.nio.Buffer data;

  public static ArrayBufferPeer make(ArrayBuffer self) { return new ArrayBufferPeer(); }

  public static ArrayBuffer makeFloat(List list)
  {
    ArrayBuffer buffer = ArrayBuffer.make();
    makeFloat$(buffer, list);
    return buffer;
  }
  public static void makeFloat$(ArrayBuffer self, List list)
  {
    FloatBuffer buf = BufferUtils.createFloatBuffer((int)list.size());
    buf.put(toFloatArray(list));
    buf.flip();
    self.peer.data = buf;
  }

  public static ArrayBuffer makeInt(List list)
  {
    ArrayBuffer buffer = ArrayBuffer.make();
    makeInt$(buffer, list);
    return buffer;
  }
  public static void makeInt$(ArrayBuffer self, List list)
  {
    IntBuffer buf = BufferUtils.createIntBuffer((int)list.size());
    buf.put(toIntArray(list));
    buf.flip();
    self.peer.data = buf;
  }

  public static ArrayBuffer makeShort(List list)
  {
    ArrayBuffer buffer = ArrayBuffer.make();

    ShortBuffer buf = BufferUtils.createShortBuffer((int)list.size());
    buf.put(toShortArray(list));
    buf.flip();
    buffer.peer.data = buf;

    return buffer;
  }

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

  public java.nio.Buffer getValue() { return data; }

//////////////////////////////////////////////////////////////////////////
// util
//////////////////////////////////////////////////////////////////////////

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