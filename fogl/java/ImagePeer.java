//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-07-29  Jed Young  Creation
//

package fan.fogl;

import fan.sys.*;
import java.nio.*;
import java.io.*;
import javax.imageio.ImageIO;
import java.awt.image.*;

import org.lwjgl.BufferUtils;


class ImagePeer
{
  private java.nio.Buffer data;
  private int width;
  private int height;

  public static ImagePeer make(Image self) { return new ImagePeer(); }

  public void load(Image self, Func f)
  {
    InputStream in = SysInStream.java(self.uri.toFile().in());
    BufferedImage bimage;
    try
    {
      bimage = ImageIO.read(in);
    }
    catch(IOException e)
    {
      throw new Err(e);
    }

    width = bimage.getWidth();
    height = bimage.getHeight();

    data = ImageConverter.convert(bimage);

    f.call(self);
  }

  public java.nio.Buffer getValue() { return data; }
  public long width(Image self) { return self.peer.width; }
  public long height(Image self) { return self.peer.height; }
}