
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2021-9-9  Jed Young  Creation
//

using vaseGraphics


const class NGfxEnv : GfxEnv
{
  private const Int handle
  static const NGfxEnv cur := NGfxEnv()

//////////////////////////////////////////////////////////////////////////
// Font Support
//////////////////////////////////////////////////////////////////////////

  **
  ** make font
  **
  override Font makeFont(|Font| f) {
    font := NFont.privateMake(f)
    initFont(font)
    return font
  }

  private native Void initFont(NFont font)

//////////////////////////////////////////////////////////////////////////
// Image op
//////////////////////////////////////////////////////////////////////////

  private static Void loadFromWeb(Image p, Uri uri, |Image|? onLoad) {
    v := concurrent::Actor.locals().get("vaseWindow.loadImage");
    if (v == null) throw Err.make("not found vaseWindow.loadImage");
    ((Func)v).call(p, uri, onLoad);
  }

  override Image fromUri(Uri uri, |Image|? onLoad) {
    if ("http".equals(uri.scheme) || "https".equals(uri.scheme)) {
      onLoad = onLoad.toImmutable();
      Image p = NImage.privateMake();
      loadFromWeb(p, uri, onLoad);
      return p;
    }
    InStream? fin = null;
    if (uri.scheme != null) {
      fin = ((File) uri.get()).in();
    }
    else {
      fin = ((File) uri.toFile()).in();
    }
    
    image := fromStream(fin)
    fin.close();
    if (onLoad != null) onLoad.call(image);
    return image;
  }

  override Image makeImage(Size size) { allocImage(size.w, size.h) }
  private native Image allocImage(Int w, Int h)

  native override Image fromStream(InStream in)

  override Void _swapImage(Image dscImg, Image newImg) {
    ((NImage)dscImg).swap(newImg)
  }

//////////////////////////////////////////////////////////////////////////
// Other
//////////////////////////////////////////////////////////////////////////

  native override Bool contains(GraphicsPath path, Float x, Float y)

  override PointArray makePointArray(Int size) {
    NPointArray.alloc(size)
  }

  protected native override Void finalize()
}