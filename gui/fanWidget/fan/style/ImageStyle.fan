//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanWt
using fan2d

class ImageStyle : WidgetStyle
{
  override Void paint(Widget widget, Graphics g)
  {
    ImageView img := widget
    g.drawImage(img.image, 0, 0)
  }
}