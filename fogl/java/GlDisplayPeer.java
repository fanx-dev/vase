//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;

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

  public void open(GlDisplay self)
  {
    Display.setDisplayMode(new DisplayMode(self.w(), self.h()));
    Display.setVSyncEnabled(true);
    Display.setTitle("Shader Setup");
    Display.create();

    gl = new GlContext();
    self.init(gl);

    while(!done)
    {
      if(Display.isCloseRequested()) done = true;
      render();
      Display.update();
    }

    Display.destroy();
  }

  public void repaint()
  {
    self.onPaint(gl);
  }
}