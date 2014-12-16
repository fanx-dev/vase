package fan.fgfxFwt;


import org.eclipse.swt.graphics.Rectangle;

import fan.fgfxGraphics.ConstImage;
import fan.fgfxGraphics.Size;

public class SwtConstImage implements ConstImage{

  private org.eclipse.swt.graphics.Image image;

  public org.eclipse.swt.graphics.Image getImage(){ return image; };

  SwtConstImage(org.eclipse.swt.graphics.Image image) {
    this.image = image;
  }

  @Override
  public Size size() {
    Rectangle r = image.getBounds();
    return Size.make(r.width, r.height);
  }

  @Override
  public boolean isReady() { return true; }
}