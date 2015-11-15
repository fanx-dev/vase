package fan.fgfxWtk;

import java.awt.image.BufferedImage;

import fan.fgfxGraphics.ConstImage;
import fan.fgfxGraphics.Size;

public class WtkConstImage implements ConstImage{

  private BufferedImage image;
  public BufferedImage getImage(){ return image; };

  WtkConstImage(BufferedImage image) {
    this.image = image;
  }

  @Override
  public Size size() {
    return Size.make(image.getWidth(null), image.getHeight(null));
  }

  @Override
  public boolean isReady() { return true; }

}