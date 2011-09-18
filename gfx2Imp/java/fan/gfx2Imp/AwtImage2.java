//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-18  Jed Young  Creation
//

package fan.gfx2Imp;

import java.awt.image.BufferedImage;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import fan.gfx.Size;
import fan.gfx2.Graphics2;
import fan.gfx2.Image2;
import fan.sys.Err;
import fan.sys.MimeType;
import fan.sys.OutStream;
import fan.sys.UnsupportedErr;
import fanx.interop.Interop;

public class AwtImage2 implements Image2
{
    private BufferedImage image;
    public BufferedImage getImage(){ return image; };

    public AwtImage2(BufferedImage m)
    {
      image = m;
    }

    public AwtImage2(){}

    public void setImage(BufferedImage image)
    {
      this.image = image;
    }

    public Size size()
    {
      return Size.make(image.getWidth(null), image.getHeight(null));
    }

    public fan.gfx.Color getPixel(long x, long y)
    {
      int rgb = image.getRGB((int)x, (int)y);
      return fan.gfx.Color.make(rgb, true);
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
    public boolean isLoaded() { return image != null; }

    /**
     * get graphics context from image
     */
    public Graphics2 graphics()
    {
      return new AwtGraphics(image.createGraphics());
    }
}