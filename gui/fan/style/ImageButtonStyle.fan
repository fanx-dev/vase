
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
      dst := Rect(widget.x, widget.y, widget.width, widget.height)
  //    echo("src$src,dst$dst")
      g.copyImage(backgroundImage, src, dst)
    }

    Button bt := widget
    if (bt.state == Button.mouseDown) {
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
    

    drawText(widget, g, bt.text, bt.textAlign)
  }
}