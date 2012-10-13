//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-18  Jed Young  Creation
//

package fan.fgfxWtk;

import java.io.OutputStream;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.ImageData;
import org.eclipse.swt.graphics.ImageLoader;

import fan.fgfx2d.*;
import fan.sys.MimeType;
import fan.sys.OutStream;
import fan.sys.UnsupportedErr;
import fanx.interop.Interop;

public class SwtImage implements BufImage {
  private boolean imageChanged = false;
  private boolean painted = false;
  private boolean isLoaded = false;

  private org.eclipse.swt.graphics.Image image;
  private org.eclipse.swt.graphics.ImageData imageData;

  public void setImage(org.eclipse.swt.graphics.Image m)
  {
    image = m;
    imageData = m.getImageData();
    isLoaded = true;
  }
  
  public org.eclipse.swt.graphics.Image getImage()
  {
    if (!imageChanged) return image;
    if (!isLoaded) return null;

    //create new image
    image.dispose();
    image = new org.eclipse.swt.graphics.Image(SwtUtil.getDisplay(), imageData);
    imageChanged = false;
    return image;
  }

  public ImageData getImageData()
  {
    if (painted)
    {
      imageData = image.getImageData();
      painted = false;
    }
    return imageData;
  }

  public Size size() {
    return Size.make(imageData.width, imageData.height);
  }

  public long getPixel(long x, long y) {
    ImageData data = getImageData();
    return data.getPixel((int) x, (int) y);
  }

  public void setPixel(long x, long y, long value) {
    ImageData data = getImageData();
    data.setPixel((int)x, (int)y, (int)value);
    imageChanged = true;
  }

  /**
   * save image to outSteam
   */
  public void save(OutStream out, MimeType format)
  {
    ImageLoader loader = new ImageLoader();
    loader.data = new ImageData[] { getImageData() };
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

  public void save(OutStream out) {
    save(out, MimeType.forExt("png"));
  }

  public boolean isLoaded() {
    return image != null;
  }

  /**
   * get graphics context from image
   */
  public Graphics graphics() {
    int w = (int)size().w;
    int h = (int)size().h;
    painted = true;
    return new SwtGraphics(new GC(getImage()), 0, 0, w, h);
  }

  @Override
  public void dispose() {
    if (!image.isDisposed()) image.dispose();
  }
  
  /**
   * auto free resource
   */
  @Override
  protected void finalize()
  {
    dispose();
  }

  @Override
  public ConstImage toConst() {
    throw UnsupportedErr.make();
  }
}