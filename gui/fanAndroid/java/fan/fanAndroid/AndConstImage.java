package fan.fanAndroid;

import android.graphics.Bitmap;
import fan.fan2d.ConstImage;
import fan.fan2d.Size;

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
