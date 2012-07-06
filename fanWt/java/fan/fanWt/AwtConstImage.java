package fan.fanWt;

import java.awt.image.BufferedImage;

import fan.fan2d.ConstImage;
import fan.fan2d.Size;

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
