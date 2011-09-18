package fan.gfx2Imp;

import java.io.OutputStream;

import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.Canvas;
import fan.gfx.Color;
import fan.gfx.Image;
import fan.gfx.Size;
import fan.gfx2.Graphics2;
import fan.gfx2.Image2;
import fan.sys.MimeType;
import fan.sys.OutStream;
import fan.sys.UnsupportedErr;
import fanx.interop.Interop;

public class AndImage2  implements Image2{
	
	private Bitmap image;
	public Bitmap getImage(){ return image; };
	
	public void setImage(Bitmap img){
		image = img;
	}

	@Override
	public Color getPixel(long x, long y) {
		int argb = image.getPixel((int)x, (int)y);
	    return fan.gfx.Color.make(argb, true);
	}

	@Override
	public Graphics2 graphics() {
		return new AndGraphics(new Canvas(image));
	}

	@Override
	public boolean isLoaded() {
		return image != null;
	}

	@Override
	public void save(OutStream out) {
		save(out, MimeType.forExt("png"));
	}

	@Override
	public void save(OutStream out, MimeType format) {
		OutputStream jout = Interop.toJava(out);
	    
	    CompressFormat swtFormat = Bitmap.CompressFormat.PNG;
	    String subType = format.subType();
	    if (subType.equals("png")) swtFormat = Bitmap.CompressFormat.PNG;
	    else if (subType.equals("jpeg")) swtFormat = Bitmap.CompressFormat.JPEG;
	    else if (subType.equals("jpg")) swtFormat = Bitmap.CompressFormat.JPEG;
	    else throw UnsupportedErr.make("unsupported image type: "+subType);
	    
	    image.compress(swtFormat, 90, jout);
	}

	@Override
	public void setPixel(long x, long y, Color value) {
		image.setPixel((int)x, (int)y, (int)value.argb);
	}

	@Override
	public Size size() {
		return Size.make(image.getWidth(), image.getHeight());
	}

	@Override
	public Image toImage() {
		throw UnsupportedErr.make();
	}

}
