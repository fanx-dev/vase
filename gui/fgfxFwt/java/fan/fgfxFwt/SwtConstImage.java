package fan.fgfxFwt;


import org.eclipse.swt.graphics.Rectangle;

import fan.fgfx2d.ConstImage;
import fan.fgfx2d.Size;

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

}