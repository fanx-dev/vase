// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-17 yangjiandong Creation
//
using vaseGraphics

@Js
class BubbleStyle : WidgetStyle
{
  Int arc := 50
  static const Int topLeft := 0
  static const Int topRight := 1
  static const Int bottomLeft := 2
  static const Int bottomRight := 3
  
  Int position := topLeft
  
  new make() {
    background = color
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    l := dpToPixel(5)
    top := l//widget.paddingTop
    left := l//widget.paddingLeft
    bottom := widget.height-l//top + widget.contentHeight
    right :=  widget.width-l//left + widget.contentWidth
    
    w := widget.width - l - l
    h := widget.height - l - l


    a := dpToPixel(arc)
    g.brush = background
    g.fillRoundRect(top, left, w, h, a, a)
    
    cornerSize := a
    pa := PointArray(3)
    if (position == topLeft) {
        pa.setX(0, left); pa.setY(0, top)
        pa.setX(1, left); pa.setY(1, top+cornerSize)
        pa.setX(2, left+cornerSize); pa.setY(2, top+cornerSize)
    }
    else if (position == topRight) {
        pa.setX(0, right-cornerSize); pa.setY(0, top+cornerSize)
        pa.setX(1, right); pa.setY(1, top+cornerSize)
        pa.setX(2, right); pa.setY(2, top)
    }
    else if (position == bottomLeft) {
        pa.setX(0, left); pa.setY(0, bottom-cornerSize)
        pa.setX(1, left); pa.setY(1, bottom)
        pa.setX(2, left+cornerSize); pa.setY(2, bottom-cornerSize)
    }
    else {
        pa.setX(0, right-cornerSize)
        pa.setY(0, bottom)
        pa.setX(1, right)
        pa.setY(1, bottom)
        pa.setX(2, right-cornerSize)
        pa.setY(2, bottom-cornerSize)
    }
    
    g.fillPolygon(pa)
  }
}