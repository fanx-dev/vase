//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-18  Jed Young  Creation
//

package fan.fanWt;

import java.awt.image.BufferedImage;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import fan.fan2d.*;
import fan.sys.Err;
import fan.sys.MimeType;
import fan.sys.OutStream;
import fan.sys.UnsupportedErr;
import fanx.interop.Interop;

public class AwtImage implements BufImage
{
    private BufferedImage image;
    public BufferedImage getImage(){ return image; };

    public void setImage(BufferedImage image)
    {
      this.image = image;
    }

    public Size size()
    {
      return Size.make(image.getWidth(null), image.getHeight(null));
    }

    public long getPixel(long x, long y)
    {
      return image.getRGB((int)x, (int)y);
    }
    public void setPixel(long x, long y, long value)
    {
      image.setRGB((int)x, (int)y, (int)value);
    }

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
    public Graphics graphics()
    {
      return new AwtGraphics(image.createGraphics());
    }

  @Override
  public void dispose() {
  }

  @Override
  public ConstImage toConst() {
    throw UnsupportedErr.make();
  }
}