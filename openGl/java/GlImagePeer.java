//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-29  Jed Young  Creation
//

package fan.vaseOpenGl;

import fan.sys.*;
import java.nio.*;
import java.io.*;
import javax.imageio.ImageIO;
import java.awt.image.*;

import org.lwjgl.BufferUtils;
import fanx.interop.Interop;
import java.nio.ByteBuffer;
import java.nio.IntBuffer;
import org.lwjgl.system.MemoryStack;

import static org.lwjgl.opengl.GL11.*;
import static org.lwjgl.opengl.GL13.GL_CLAMP_TO_BORDER;
import static org.lwjgl.stb.STBImage.*;

class GlImagePeer
{
  private java.nio.Buffer data;
  private int width;
  private int height;

  public static GlImagePeer make(GlImage self) { return new GlImagePeer(); }

  public void load(GlImage self, Func f) throws FileNotFoundException
  {
    String path = self.uri.toFile().osPath();
    ByteBuffer image;
    //int width, height;
    try (MemoryStack stack = MemoryStack.stackPush()) {
        /* Prepare image buffers */
        IntBuffer w = stack.mallocInt(1);
        IntBuffer h = stack.mallocInt(1);
        IntBuffer comp = stack.mallocInt(1);

        /* Load image */
        stbi_set_flip_vertically_on_load(true);
        image = stbi_load(path, w, h, comp, 4);
        if (image == null) {
            throw new RuntimeException("Failed to load a texture file!"
                                       + System.lineSeparator() + stbi_failure_reason());
        }

        /* Get width and height of image */
        width = w.get();
        height = h.get();
    }
    data = image;
    f.call(self);
  }

  public java.nio.Buffer getValue() { return data; }
  public long width(GlImage self) { return self.peer.width; }
  public long height(GlImage self) { return self.peer.height; }
}