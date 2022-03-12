
using vaseGraphics

@Js
class ImageButtonStyle : WidgetStyle
{
  Image? image
  
  new make() {
    background = Color(0xf2f2f2)
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    if (backgroundImage != null && backgroundImage.isReady) {
      Size srcSize := backgroundImage.size
      src := Rect(0, 0, srcSize.w, srcSize.h)
      dst := Rect(0, 0, widget.width, widget.height)
  //    echo("src$src,dst$dst")
      g.copyImage(backgroundImage, src, dst)
    }

    Button btn := widget
    if (btn.state == Button.mouseDown) {
        g.brush = background
        g.alpha = 100
        g.fillRect(0, 0, widget.width, widget.height)
        g.alpha = 255
    }

    if (image != null && image.isReady) {
      Size srcSize := image.size
      src := Rect(0, 0, srcSize.w, srcSize.h)
      dst := Rect(widget.paddingLeft, widget.paddingTop, widget.contentWidth, widget.contentHeight)
  //    echo("src$src,dst$dst")
      g.copyImage(image, src, dst)
    }
    
    if (btn.ripplePoint != null && btn.rippleSize > 0.0) {
        g.brush = rippleColor
        r := (btn.rippleSize * (100+btn.width)).toInt
        alpha := (256 * (1-btn.rippleSize)).toInt
        if (alpha > 200) alpha = 200
        g.alpha = alpha
        w := r+r
        g.fillOval(btn.ripplePoint.x-r, btn.ripplePoint.y-r, w, w)
        g.alpha = 255
    }

    drawText(widget, g, btn.text, btn.textAlign)
  }
}