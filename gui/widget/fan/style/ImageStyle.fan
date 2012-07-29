//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class ImageStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    ImageView img := widget
    g.drawImage(img.image, 0, 0)
  }
}