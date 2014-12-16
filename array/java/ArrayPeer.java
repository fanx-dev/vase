//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fgfxArray;

import fan.sys.*;

public class ArrayPeer
{
  private Object array;
  private NumType type;

  public static ArrayPeer make(Array self) { return new ArrayPeer(); }

//////////////////////////////////////////////////////////////////////////
// fields
//////////////////////////////////////////////////////////////////////////

  public long size(Array self)
  {
    if (type == NumType.tByte)
    {
      return ((byte[])array).length;
    }
    else if (type == NumType.tFloat)
    {
      return ((float[])array).length;
    }
    else if (type == NumType.tDouble)
    {
      return ((double[])array).length;
    }
    else if(type == NumType.tInt)
    {
      return ((int[])array).length;
    }
    else if(type == NumType.tShort)
    {
      return ((short[])array).length;
    }
    else if(type == NumType.tLong)
    {
      return ((long[])array).length;
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

  public NumType type(Array self) { return type; }

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

  public static Array allocate(long size, NumType type)
  {
    Array array = Array.make();
    array.peer.type = type;

    int n = (int)size;
    if (type == NumType.tByte)
    {
      array.peer.array = new byte[n];
    }
    else if (type == NumType.tFloat)
    {
      array.peer.array = new float[n];
    }
    else if (type == NumType.tDouble)
    {
      array.peer.array = new double[n];
    }
    else if(type == NumType.tInt)
    {
      array.peer.array = new int[n];
    }
    else if(type == NumType.tShort)
    {
      array.peer.array = new short[n];
    }
    else if(type == NumType.tLong)
    {
      array.peer.array = new long[n];
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
    return array;
  }
  public static Array allocate(long size)
  {
    return allocate(size, NumType.tInt);
  }

//////////////////////////////////////////////////////////////////////////
// random read/write
//////////////////////////////////////////////////////////////////////////

  public long getInt(Array self, long index)
  {
    int i = (int)index;
    if (type == NumType.tByte)
    {
      return ((byte[])array)[i];
    }
    else if(type == NumType.tInt)
    {
      return ((int[])array)[i];
    }
    else if(type == NumType.tShort)
    {
      return ((short[])array)[i];
    }
    else if(type == NumType.tLong)
    {
      return ((long[])array)[i];
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }
  public Array setInt(Array self, long index, long v)
  {
    int i = (int)index;
    if (type == NumType.tByte)
    {
      ((byte[])array)[i] = (byte)v;
    }
    else if(type == NumType.tInt)
    {
      ((int[])array)[i] = (int)v;
    }
    else if(type == NumType.tShort)
    {
      ((short[])array)[i] = (short)v;
    }
    else if(type == NumType.tLong)
    {
      ((long[])array)[i] = (long)v;
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
    return self;
  }

  public double getFloat(Array self, long index)
  {
    int i = (int)index;
    if (type == NumType.tFloat)
    {
      return ((float[])array)[i];
    }
    else if (type == NumType.tDouble)
    {
      return ((double[])array)[i];
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }
  public Array setFloat(Array self, long index, double v)
  {
    int i = (int)index;
    if (type == NumType.tFloat)
    {
      ((float[])array)[i] = (float)v;
    }
    else if (type == NumType.tDouble)
    {
      ((double[])array)[i] = (double)v;
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
    return self;
  }

//////////////////////////////////////////////////////////////////////////
// batch read/write
//////////////////////////////////////////////////////////////////////////

  public static Array fromList(Array self, List list, NumType type)
  {
    Array array = Array.make();
    array.peer.array = ArrayUtil.listToArray(list, type);
    array.peer.type = type;
    return array;
  }

  public List toList(Array self)
  {
    if (type == NumType.tByte || type == NumType.tInt || type == NumType.tShort || type == NumType.tLong)
    {
      int size = (int)size(self);
      List list = List.make(Sys.IntType, size);
      for (int i = 0; i < size; ++i)
      {
        list.add(getInt(self, i));
      }
      return list;
    }
    else if (type == NumType.tFloat || type == NumType.tDouble)
    {
      int size = (int)size(self);
      List list = List.make(Sys.FloatType, size);
      for (int i = 0; i < size; ++i)
      {
        list.add(getFloat(self, i));
      }
      return list;
    }
    else
    {
      throw UnsupportedErr.make("unsupported type");
    }
  }

//////////////////////////////////////////////////////////////////////////
// copy
//////////////////////////////////////////////////////////////////////////

  public void copyTo(Array self, Array dst, long dstOffset, long srcOffset, long size)
  {
    System.arraycopy(self.peer.array, (int)srcOffset, dst.peer.array, (int)dstOffset, (int)size);
  }
  public void copyTo(Array self, Array dst, long dstOffset, long srcOffset)
  {
    copyTo(self, dst, dstOffset, srcOffset, this.size(self));
  }
  public void copyTo(Array self, Array dst, long dstOffset)
  {
    copyTo(self, dst, dstOffset, 0);
  }
  public void copyTo(Array self, Array dst)
  {
    copyTo(self, dst, 0);
  }

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

  public Object getValue()
  {
    return array;
  }
}