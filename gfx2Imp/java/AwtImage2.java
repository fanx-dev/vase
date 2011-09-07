//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-18  Jed Young  Creation
//

package fan.gfx2Imp;

import fan.sys.*;
import fan.gfx.*;
import fan.gfx2.*;

import java.io.*;
import fanx.interop.Interop;

import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import javax.imageio.ImageIO;

public class AwtImage2 implements Image2
{
    private BufferedImage image;
    public BufferedImage getImage(){ return image; };

    public AwtImage2(BufferedImage m)
    {
      image = m;
    }

    public Size size()
    {
      return Size.make(image.getWidth(null), image.getHeight(null));
    }

    public fan.gfx.Color getPixel(long x, long y)
    {
      int rgb = image.getRGB((int)x, (int)y);
      return fan.gfx.Color.make(rgb, false);
    }
    public void setPixel(long x, long y, fan.gfx.Color value)
    {
      image.setRGB((int)x, (int)y, (int)value.argb);
    }

    public fan.gfx.Image toImage() { throw UnsupportedErr.make(); }

    /**
     * save image to outSteam
     */
    public void save(OutStream out, MimeType format)
    {
      OutputStream jout = Interop.toJava(out);
      String subType = format.subType();

      try
      {
        ImageIO.write(image, subType, jout);
      }
      catch(java.io.IOException e)
      {
        throw Err.make(e);
      }
    }
    public void save(OutStream out)
    {
      save(out, MimeType.forExt("png"));
    }
    public boolean isLoaded() { return true; }

    /**
     * get graphics context from image
     */
    public Graphics2 graphics()
    {
      //return new AwtGraphics(image.createGraphics());
      return null;
    }
}

