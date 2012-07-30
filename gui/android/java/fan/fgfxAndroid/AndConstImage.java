package fan.fgfxAndroid;

import android.graphics.Bitmap;
import fan.fgfx2d.ConstImage;
import fan.fgfx2d.Size;

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
}