//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-18  Jed Young  Creation
//
package fan.vaseAndroid;

import java.io.OutputStream;

import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.Canvas;
import fan.vaseGraphics.*;
import fan.sys.*;
import fan.std.*;
import fanx.interop.Interop;

public class AndImage extends Image {

  private Bitmap image;
  public Bitmap getImage(){ return image; };

  public void setImage(Bitmap img){
    image = img;
  }

  private void toMutable() {
    if (image == null) return;
    if (image.isMutable()) return;
    image = image.copy(Bitmap.Config.ARGB_8888, true);
  }

  @Override
  public long getPixel(long x, long y) {
    int argb = image.getPixel((int)x, (int)y);
    return argb;
  }

  @Override
  public Graphics createGraphics() {
    return new AndGraphics(new Canvas(image));
  }

  public boolean isLoaded() {
    return image != null;
  }

  @Override
  public boolean isReady() {
    return image != null;
  }

  @Override
  public void save(OutStream out) {
    save(out, "png");
  }

  @Override
  public void save(OutStream out, String format) {
    OutputStream jout = Interop.toJava(out);

      CompressFormat swtFormat = Bitmap.CompressFormat.PNG;
      String subType = format;
      if (subType.equals("png")) swtFormat = Bitmap.CompressFormat.PNG;
      else if (subType.equals("jpeg")) swtFormat = Bitmap.CompressFormat.JPEG;
      else if (subType.equals("jpg")) swtFormat = Bitmap.CompressFormat.JPEG;
      else throw UnsupportedErr.make("unsupported image type: "+subType);

      image.compress(swtFormat, 90, jout);
  }

  @Override
  public void setPixel(long x, long y, long value) {
    toMutable();
    image.setPixel((int)x, (int)y, (int)value);
  }

  
  public Size size() {
    return Size.make(image.getWidth(), image.getHeight());
  }
  @Override
  public long width() {
    return image.getWidth();
  }
  @Override
  public long height() {
    return image.getHeight();
  }

  // @Override
  // public ConstImage toConst() {
  //   throw UnsupportedErr.make();
  // }

  @Override
  public void dispose() {
    image.recycle();
  }

}