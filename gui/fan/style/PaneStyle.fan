
using vaseGraphics

@Js
class PaneStyle : WidgetStyle
{
  Float arc := 40f
  
  new make() {
    outlineColor = Color.gray
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    if (lineWidth > 0f) {
      l := dpToPixel(lineWidth/2)
      x := l
      y := l
      w := widget.width - l - l
      h := widget.height - l - l

      g.brush = outlineColor
      g.pen = Pen { width = dpToPixel(lineWidth) }
      a := dpToPixel(arc)
      
      //echo("=== $x, $y, $w, $h, $a")
      g.drawRoundRect(x, y, w, h, a, a)
    }

    if (backgroundImage != null) {
      Size srcSize := backgroundImage.size
      src := Rect(0, 0, srcSize.w, srcSize.h)
      dst := Rect(widget.x, widget.y, widget.width, widget.height)
  //    echo("src$src,dst$dst")
      g.copyImage(backgroundImage, src, dst)
    }
  }
}