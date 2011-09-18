package fan.gfx2Imp;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Region;
import fan.gfx.Size;
import fan.gfx2.GfxEnv2;
import fan.gfx2.Image2;
import fan.gfx2.Path;
import fan.sys.Func;
import fan.sys.IOErr;
import fan.sys.SysInStream;
import fan.sys.Uri;

public class AndGfxEnv2 extends GfxEnv2 {

	@Override
	public boolean contains(Path path, double x, double y) {
		android.graphics.Path p = AndUtil.toAndPath(path);
		Region r = new Region();
		r.setPath(p, null);
		return r.contains((int) x, (int) y);
	}

	@Override
	public Image2 fromUri(Uri uri, Func onLoad) {
		onLoad = (Func) onLoad.toImmutable();
		if (uri.scheme().equals("http")) {
			AndImage2 p = new AndImage2();
			loadFromWeb(p, uri, onLoad);
			return p;
		}

		InputStream jin = SysInStream.java(((fan.sys.File) uri.get()).in());
		Bitmap image = BitmapFactory.decodeStream(jin);
		AndImage2 p = new AndImage2();
		p.setImage(image);
		onLoad.call(p);
		return p;
	}

	private static void loadFromWeb(final AndImage2 p, final Uri uri, final Func onLoad) {
		new Thread(new Runnable() {
			public void run() {
				InputStream jin;
				try {
					URL requestUrl = new URL(uri.toStr());
					URLConnection con = requestUrl.openConnection();
					jin = con.getInputStream();
				} catch (IOException e) {
					throw IOErr.make(e);
				}

				Bitmap image = BitmapFactory.decodeStream(jin);
				p.setImage(image);
				onLoad.call(p);
			}
		}).start();
	}

	@Override
	public Image2 makeImage2(Size size) {
		Bitmap image = Bitmap.createBitmap((int) size.w, (int) size.h,
				Bitmap.Config.ARGB_8888);
		AndImage2 p = new AndImage2();
		p.setImage(image);
		return p;
	}

}
