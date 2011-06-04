//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;


class GlEnumPeer
{
  private int value;

  public static GlEnumPeer make(GlEnum self)
  {
    return new GlEnumPeer();
  }

  public GlEnum mix(GlEnum e)
  {
    GlEnum e2 = GlEnum.make();
    e2.peer.value =  this.value | e.peer.value;
    return e2;
  }

  public int getValue(){ return value; }
  public void setValue(int v){ value = v; }
}