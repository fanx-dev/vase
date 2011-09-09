//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-09-09  Jed Young  Creation
//
package fan.gfx2Imp;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

import fan.gfx.Font;
import fan.gfx.GfxEnv;
import fan.gfx.Image;
import fan.gfx.Size;
import fan.sys.Func;
import fan.sys.UnsupportedErr;

public class AwtGfxEnv extends GfxEnv{
	
	BufferedImage bufferedImage =  new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
	Graphics2D scratchG = bufferedImage.createGraphics();
	
	@Override
	public long fontAscent(Font f) {
		java.awt.Font font = AwtUtil.toFont(f);
		return scratchG.getFontMetrics(font).getAscent();
	}

	@Override
	public long fontDescent(Font f) {
		java.awt.Font font = AwtUtil.toFont(f);
		return scratchG.getFontMetrics(font).getDescent();
	}

	@Override
	public long fontHeight(Font f) {
		java.awt.Font font = AwtUtil.toFont(f);
		return scratchG.getFontMetrics(font).getHeight();
	}

	@Override
	public long fontLeading(Font f) {
		java.awt.Font font = AwtUtil.toFont(f);
		return scratchG.getFontMetrics(font).getLeading();
	}

	@Override
	public long fontWidth(Font f, String s) {
		java.awt.Font font = AwtUtil.toFont(f);
		return scratchG.getFontMetrics(font).stringWidth(s);
	}

	@Override
	public Image imagePaint(Size size, Func arg1) {
		throw UnsupportedErr.make();
	}

	@Override
	public Image imageResize(Image arg0, Size arg1) {
		throw UnsupportedErr.make();
	}

	@Override
	public Size imageSize(Image arg0) {
		throw UnsupportedErr.make();
	}

}
