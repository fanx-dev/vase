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
  private java.nio.Buffer bufferView;
  private ByteBuffer rawData;
  private int offset;
  private int size;

  public static ArrayBufferPeer make(ArrayBuffer self) { return new ArrayBufferPeer(); }

//////////////////////////////////////////////////////////////////////////
// fields
//////////////////////////////////////////////////////////////////////////

  public long size(ArrayBuffer self) { return size; }

  public Endian endian(ArrayBuffer self)
  {
    return (rawData.order() == ByteOrder.BIG_ENDIAN) ? Endian.big : Endian.little;
  }
  public void endian(ArrayBuffer self, Endian v)
  {
    rawData.order(v == Endian.big ? ByteOrder.BIG_ENDIAN : ByteOrder.LITTLE_ENDIAN);
  }

  public NumType type(ArrayBuffer self)
  {
    java.nio.Buffer d = getValue();
    if(d instanceof java.nio.ByteBuffer)
    {
      return NumType.tByte;
    }
    else if (d instanceof java.nio.FloatBuffer)
    {
      return NumType.tFloat;
    }
    else if (d instanceof java.nio.DoubleBuffer)
    {
      return NumType.tDouble;
    }
    else if(d instanceof java.nio.IntBuffer)
    {
      return NumType.tInt;
    }
    else if(d instanceof java.nio.ShortBuffer)
    {
      return NumType.tShort;
    }
    else if(d instanceof java.nio.LongBuffer)
    {
      return NumType.tLong;
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }
/*
  public long capacity(ArrayBuffer self) { return getValue().capacity(); }
  public boolean isDirect(ArrayBuffer self) { return getValue().isDirect(); }

  public ArrayBuffer flip(ArrayBuffer self) { getValue().flip(); return self; }
  public long remaining(ArrayBuffer self) { return getValue().remaining(); }
*/
  private void reset()
  {
    getValue().position(this.offset);
    getValue().limit(this.size);
  }

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

  public static ArrayBuffer allocateDirect(long size, NumType type)
  {
    int capacity = (int)(size * type.size);
    ByteBuffer buf = ByteBuffer.allocateDirect(capacity).order(ByteOrder.nativeOrder());
    buf.clear();

    ArrayBuffer ab = ArrayBuffer.make();
    ab.peer.rawData = buf;
    if (type != NumType.tByte) ab.peer.bufferView = asView(buf, type);
    ab.peer.offset = 0;
    ab.peer.size = (int)size;
    return ab;
  }
  public static ArrayBuffer allocateDirect(long size)
  {
    return allocateDirect(size, NumType.tByte);
  }

  private static java.nio.Buffer asView(ByteBuffer buf, NumType v)
  {
    if (v == NumType.tByte)
    {
      return buf.slice();
    }
    else if (v == NumType.tFloat)
    {
      return buf.asFloatBuffer();
    }
    else if (v == NumType.tDouble)
    {
      return buf.asDoubleBuffer();
    }
    else if(v == NumType.tInt)
    {
      return buf.asIntBuffer();
    }
    else if(v == NumType.tShort)
    {
      return buf.asShortBuffer();
    }
    else if(v == NumType.tLong)
    {
      return buf.asLongBuffer();
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

  public ArrayBuffer createView(ArrayBuffer self, NumType type, long offset, long size)
  {
    if (type(self) != NumType.tByte) throw UnsupportedErr.make("only ByteBuffer can create view");

    this.rawData.position((int)offset);
    this.rawData.limit((int)(offset + size * type.size));

    ArrayBuffer view = ArrayBuffer.make();
    view.peer.rawData = this.rawData;
    view.peer.bufferView = asView(rawData, type);
    view.peer.offset = (int)offset;
    view.peer.size = (int)size;
    reset();

    return view;
  }

  public ArrayBuffer createView(ArrayBuffer self, NumType type, long offset)
  {
    return createView(self, type, offset, this.size / type.size);
  }

  public ArrayBuffer createView(ArrayBuffer self, NumType type)
  {
    return createView(self, type, this.offset);
  }

//////////////////////////////////////////////////////////////////////////
// random read/write
//////////////////////////////////////////////////////////////////////////

  public long getInt(ArrayBuffer self, long index)
  {
    IntBuffer buf = (IntBuffer)getValue();
    return buf.get((int)index);
  }
  public ArrayBuffer set(ArrayBuffer self, long index, long v)
  {
    IntBuffer buf = (IntBuffer)getValue();
    buf.put((int)index, (int)v);
    return self;
  }

  public double getFloat(ArrayBuffer self, long index)
  {
    FloatBuffer buf = (FloatBuffer)getValue();
    return buf.get((int)index);
  }
  public ArrayBuffer setFloat(ArrayBuffer self, long index, double v)
  {
    FloatBuffer buf = (FloatBuffer)getValue();
    buf.put((int)index, (float)v);
    return self;
  }

//////////////////////////////////////////////////////////////////////////
// batch read/write
//////////////////////////////////////////////////////////////////////////

  public ArrayBuffer putFloat(ArrayBuffer self, List list)
  {
    FloatBuffer buf = (FloatBuffer)getValue();
    buf.put(toFloatArray(list));
    reset();
    return self;
  }
  public ArrayBuffer putInt(ArrayBuffer self, List list)
  {
    IntBuffer buf = (IntBuffer)getValue();
    buf.put(toIntArray(list));
    reset();
    return self;
  }
  public ArrayBuffer putShort(ArrayBuffer self, List list)
  {
    ShortBuffer buf = (ShortBuffer)getValue();
    buf.put(toShortArray(list));
    reset();
    return self;
  }

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

  public java.nio.Buffer getValue()
  {
    if (bufferView != null) return bufferView;
    return rawData;
  }

  public void getValue(java.nio.ByteBuffer buf)
  {
    bufferView = null;
    rawData = buf;
  }

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