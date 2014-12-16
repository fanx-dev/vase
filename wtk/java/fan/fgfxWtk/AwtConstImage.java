package fan.fgfxWtk;

import java.awt.image.BufferedImage;

import fan.fgfxGraphics.ConstImage;
import fan.fgfxGraphics.Size;

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

  @Override
  public boolean isReady() { return true; }

}