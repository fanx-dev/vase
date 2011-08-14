//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-14  Jed Young  Creation
//

package fan.gfx2Imp;

import fan.sys.*;
import fan.gfx.*;
import fan.gfx2.*;

import java.io.*;

import org.eclipse.swt.*;
import org.eclipse.swt.graphics.*;
import fanx.interop.Interop;

public class PixmapImp implements Pixmap
{
  private org.eclipse.swt.graphics.Image image;
  public org.eclipse.swt.graphics.Image getImage(){ return image; };

  public PixmapImp(org.eclipse.swt.graphics.Image m)
  {
    image = m;
  }

  public Size size()
  {
    Rectangle r = image.getBounds();
    return Size.make(r.width, r.height);
  }

  public fan.gfx.Color getPixel(long x, long y)
  {
    ImageData data= image.getImageData();
    PaletteData palette = data.palette;
    RGB rgb = palette.getRGB(data.getPixel((int)x, (int)y));
    int alpha = data.getAlpha((int)x, (int)y);
    return fan.gfx.Color.makeArgb(alpha, rgb.red, rgb.green, rgb.blue);
  }
  public void setPixel(long x, long y, fan.gfx.Color value)
  {
    ImageData data= image.getImageData();
    PaletteData palette = data.palette;
    RGB rgb = new RGB((int)value.r(), (int)value.g(), (int)value.b());
    int alpha = (int)value.a();
    int pixel = palette.getPixel(rgb);
    data.setPixel((int)x, (int)y, pixel);
    data.setAlpha((int)x, (int)y, alpha);
  }

  public fan.gfx.Image toImage() { throw UnsupportedErr.make(); }

  /**
   * save image to outSteam
   */
  public void save(OutStream out, MimeType format)
  {
    ImageLoader loader = new ImageLoader();
    loader.data = new ImageData[] { image.getImageData() };
    OutputStream jout = Interop.toJava(out);

    int swtFormat = SWT.IMAGE_PNG;
    String subType = format.subType();
    if (subType == "png") swtFormat = SWT.IMAGE_PNG;
    else if (subType == "gif") swtFormat = SWT.IMAGE_GIF;
    else if (subType == "jpeg") swtFormat = SWT.IMAGE_JPEG;
    else if (subType == "jpg") swtFormat = SWT.IMAGE_JPEG;
    else if (subType == "bmp") swtFormat = SWT.IMAGE_BMP;
    else if (subType == "tiff") swtFormat = SWT.IMAGE_TIFF;
    else if (subType == "ico") swtFormat = SWT.IMAGE_ICO;
    else throw UnsupportedErr.make("unsupported image type: "+subType);

    loader.save(jout, swtFormat);
  }
  public void save(OutStream out)
  {
    save(out, MimeType.forExt("png"));
  }

  /**
   * get graphics context from image
   */
  public Graphics2 graphics()
  {
    int w = (int)size().w;
    int h = (int)size().h;
    return new FwtGraphics2(new GC(image), 0, 0, w, h);
  }
}