//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;


class GlPointerPeer
{
  private long value;

  public static GlPointerPeer make(GlPointer self){ return new GlPointerPeer(); }

  public long val(GlPointer self){ return value; }

  public long getValue(){ return value; }
  public void setValue(long v){ value = v; }
}