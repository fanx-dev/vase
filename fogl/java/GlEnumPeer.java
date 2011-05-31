//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;

import fan.sys.*;

static import org.lwjgl.opengl.GL11.*;

class GlEnumPeer
{
  int val;

  public static GlEnumPeer make(GlEnum self)
  {
    return new GlEnumPeer();
  }

  GlEnum mix(GlEnum e)
  {
    GlEnum e2 = GlEnum.make();
    e2.peer.val =  this.val | e.peer.vl;
    return e2;
  }
}

//************************************************************************
// GlEnumFactoryPeer
//************************************************************************

class GlEnumFactoryPeer
{
  public static GlEnumFactoryPeer make(GlEnumFactory self)
  {
    return new GlEnumFactoryPeer();
  }

  GlEnum deepTest(GlEnumFactory self)
  {
    e = GlEnum.make();
    e.peer.val = GL_DEPTH_TEST;
    return e;
  }
}