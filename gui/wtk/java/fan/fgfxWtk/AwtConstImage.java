package fan.fgfxWtk;

import java.awt.image.BufferedImage;

import fan.fgfx2d.ConstImage;
import fan.fgfx2d.Size;

public class AwtConstImage implements ConstImage{

  private BufferedImage image;
  public BufferedImage getImage(){ return image; };

  AwtConstImage(BufferedImage image) {
    this.image = image;
  }

  @Override
  public Size size() {
    return Size.make(image.getWidth(null), image.getHeight(null));
  }

}