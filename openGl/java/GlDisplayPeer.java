//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fanvasOpenGl;

import fan.sys.*;

import org.lwjgl.opengl.GL11;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;
import org.lwjgl.util.glu.GLU;

class GlDisplayPeer
{
  GlContext gl;

  public static GlDisplayPeer make(GlDisplay self)
  {
    return new GlDisplayPeer();
  }

  public void open(GlDisplay self) throws Exception
  {
    Display.setDisplayMode(new DisplayMode((int)self.w(), (int)self.h()));
    Display.setVSyncEnabled(true);
    Display.setTitle("fan3d");
    Display.create();

    gl = new FanGlContext();
    self.init(gl);

    while(true)
    {
      if(Display.isCloseRequested()) break;
      repaint(self);
      Display.update();
    }

    Display.destroy();
  }

  public void repaint(GlDisplay self)
  {
    self.onPaint(gl);
  }
}