
using vaseGraphics

@Js
class PaneStyle : WidgetStyle
{
  Int arc := 5
  Bool fill := true
  Bool stroke := false
  
  Int shadow := 0
  Color shadowColor := Color.gray
  Int alpha := 255
  
  new make() {
    outlineColor = Color.gray
  }

  override Void doPaint(Widget widget, Graphics g)
  {
    l := dpToPixel(shadow)
    x := l
    y := l
    w := widget.width - l - l
    h := widget.height - l - l
    
    arc := dpToPixel(this.arc)

    if (shadow > 0) {
        fill = true
        g.brush = shadowColor
        alpha := 2
        
        for (i := dpToPixel(shadow).toFloat; i>1.0; i = i*0.8 ) {
            g.alpha = alpha
            a := (i*2).toInt
            g.pen = Pen { width = a; cap = capRound }
            shift := a / 6
            //echo("draw $a, $alpha")
            r := arc + a / 2
            g.drawRoundRect(x+shift, y+shift, w, h, r, r)
            //g.drawRect(x+shift, y+shift, w, h)
            alpha = alpha + 5
            if (alpha > 255) alpha = 255
        }
        g.alpha = 255
    }

    g.alpha = alpha
    
    if (backgroundImage != null) {
      Size srcSize := backgroundImage.size
      src := Rect(0, 0, srcSize.w, srcSize.h)
      dst := Rect(0, 0, widget.width, widget.height)
  //    echo("src$src,dst$dst")
      g.copyImage(backgroundImage, src, dst)
    }
    else if (fill){
        g.brush = background
        g.fillRoundRect(x, y, w, h, arc, arc)
    }
    
    if (lineWidth > 0) {
      //echo("=== $x, $y, $w, $h, $a")
      if (stroke) {
        g.brush = outlineColor
        lw := dpToPixel(lineWidth)
        g.pen = Pen { width = lw }
        g.drawRoundRect(x, y, w-lw, h-lw, arc, arc)
      }
    }

    g.alpha = 255
  }
}

@Js
class RectViewStyle : WidgetStyle {
  new make() {
    background = Color(0xd9d9d9)
  }
  
  override Void doPaint(Widget widget, Graphics g)
  {
    x := widget.paddingLeft
    y := widget.paddingTop
    w := widget.contentWidth
    h := widget.contentHeight
    g.brush = background
    g.fillRect(x, y, w, h)
  }
}