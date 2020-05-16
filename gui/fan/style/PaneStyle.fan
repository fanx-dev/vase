
using vaseGraphics

@Js
class PaneStyle : WidgetStyle
{
  Int arc := 40
  Bool fill := true
  Bool stroke := true
  
  new make() {
    outlineColor = Color.gray
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    if (backgroundImage != null) {
      Size srcSize := backgroundImage.size
      src := Rect(0, 0, srcSize.w, srcSize.h)
      dst := Rect(widget.x, widget.y, widget.width, widget.height)
  //    echo("src$src,dst$dst")
      g.copyImage(backgroundImage, src, dst)
    }
    
    if (lineWidth > 0) {
      l := dpToPixel(lineWidth/2)
      x := l
      y := l
      w := widget.width - l - l
      h := widget.height - l - l

      
      a := dpToPixel(arc)
      
      //echo("=== $x, $y, $w, $h, $a")
      if (fill) {
        g.brush = background
        //g.pen = Pen { width = dpToPixel(lineWidth) }
        g.fillRoundRect(x, y, w, h, a, a)
      }
      if (stroke) {
        g.brush = outlineColor
        lw := dpToPixel(lineWidth)
        g.pen = Pen { width = lw }
        g.drawRoundRect(x, y, w-lw, h-lw, a, a)
      }
    }
  }
}

@Js
class RectViewStyle : WidgetStyle {
  new make() {
    background = Color.gray
  }
  
  override Void doPaint(Widget widget, Graphics g)
  {
    x := widget.paddingLeft
    y := widget.paddingTop
    w := widget.width
    h := widget.height
    g.brush = background
    g.fillRect(x, y, w, h)
  }
}