package fan.fanvasFwt;


import org.eclipse.swt.graphics.Rectangle;

import fan.fanvasGraphics.ConstImage;
import fan.fanvasGraphics.Size;

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