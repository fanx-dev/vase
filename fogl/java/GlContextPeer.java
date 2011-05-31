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

class GlContextPeer
{
  public static GlContextPeer make(GlContext self)
  {
    return new GlContextPeer();
  }

  public void clearColor(Pointer self, double r, double g, double b, long a)
  {
    glClearColor(r, g, b, a);
  }

  public void enable(Pointer self, GlEnum e)
  {
    glEnable(e.peer.val);
  }

  public void viewport(long x, long y, long width, long height)
  {
    glViewport(x, y, width, height);
  }

  public void clear(GlEnum e)
  {
    glClear(e.peer.val);
  }

  public void vertexAttribPointer(long indx, long size, GlEnum type, boolean normalized, long stride, long offset)
  {
    glVertexAttribPointer((int)indx, (int)size, type.peer.val, normalized, (int)stride, offset);
  }

  public void drawArrays(GlEnum mode, Int first, Int count)
  {
    glDrawArrays(mode.peer.val, first, count);
  }

  public Buffer createBuffer()
  {
    int i = glGenBuffers();
    Buffer buf = Buffer.make();
    buf.peer.val = i;
    return buf;
  }
}