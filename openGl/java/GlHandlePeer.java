//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fanvasOpenGl;


class GlHandlePeer
{
  private int value;

  public static GlHandlePeer make(GlHandle self){ return new GlHandlePeer(); }

  public Object val(GlHandle self){ return value; }

  public int getValue(){ return value; }
  public void setValue(int v){ value = v; }
}