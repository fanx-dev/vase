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
  private boolean imageChanged = false;
  private org.eclipse.swt.graphics.Image image;
  private org.eclipse.swt.graphics.ImageData imageData;
  public org.eclipse.swt.graphics.Image getImage()
  {
    if (!imageChanged) return image;

    //create new image
    image.dispose();
    image = new org.eclipse.swt.graphics.Image(FwtEnv2Peer.getDisplay(), imageData);
    imageChanged = false;
    return image;
  }

  public PixmapImp(org.eclipse.swt.graphics.Image m)
  {
    image = m;
    imageData = m.getImageData();
  }

  public Size size()
  {
    //Rectangle r = image.getBounds();
    return Size.make(imageData.width, imageData.height);
  }

  public fan.gfx.Color getPixel(long x, long y)
  {
    ImageData data= imageData;
    PaletteData palette = data.palette;
    RGB rgb = palette.getRGB(data.getPixel((int)x, (int)y));
    int alpha = data.getAlpha((int)x, (int)y);
    return fan.gfx.Color.makeArgb(alpha, rgb.red, rgb.green, rgb.blue);
  }
  public void setPixel(long x, long y, fan.gfx.Color value)
  {
    ImageData data= imageData;
    PaletteData palette = data.palette;
    RGB rgb = new RGB((int)value.r(), (int)value.g(), (int)value.b());
    int alpha = (int)value.a();
    int pixel = palette.getPixel(rgb);
    data.setPixel((int)x, (int)y, pixel);
    //System.out.println(pixel);
    data.setAlpha((int)x, (int)y, alpha);
    imageChanged = true;
  }

  public fan.gfx.Image toImage() { throw UnsupportedErr.make(); }

  /**
   * save image to outSteam
   */
  public void save(OutStream out, MimeType format)
  {
    ImageLoader loader = new ImageLoader();
    loader.data = new ImageData[] { imageData };
    OutputStream jout = Interop.toJava(out);

    int swtFormat = SWT.IMAGE_PNG;
    String subType = format.subType();
    if (subType.equals("png")) swtFormat = SWT.IMAGE_PNG;
    else if (subType.equals("gif")) swtFormat = SWT.IMAGE_GIF;
    else if (subType.equals("jpeg")) swtFormat = SWT.IMAGE_JPEG;
    else if (subType.equals("jpg")) swtFormat = SWT.IMAGE_JPEG;
    else if (subType.equals("bmp")) swtFormat = SWT.IMAGE_BMP;
    else if (subType.equals("tiff")) swtFormat = SWT.IMAGE_TIFF;
    else if (subType.equals("ico")) swtFormat = SWT.IMAGE_ICO;
    else throw UnsupportedErr.make("unsupported image type: "+subType);

    loader.save(jout, swtFormat);
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
    int w = (int)size().w;
    int h = (int)size().h;
    return new FwtGraphics2(new GC(getImage()), 0, 0, w, h);
  }
}