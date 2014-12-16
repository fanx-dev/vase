package fan.fgfxAndroid;

import android.graphics.Bitmap;
import fan.fgfxGraphics.ConstImage;
import fan.fgfxGraphics.Size;

public class AndConstImage implements ConstImage {

  private Bitmap image;
  public Bitmap getImage(){ return image; };

  public void setImage(Bitmap img){
    image = img;
  }

  @Override
  public Size size() {
    return Size.make(image.getWidth(), image.getHeight());
  }

  @Override
  public boolean isReady() { return true; }
}