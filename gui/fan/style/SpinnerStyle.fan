// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-5 yangjiandong Creation
//

using vaseGraphics

**
** SpinnerStyle
**
@Js
class SpinnerStyle : WidgetStyle
{
  Bool drawCursor := false

  override Void doPaint(Widget widget, Graphics g)
  {
    Spinner lab := widget
    
    left := lab.paddingLeft
    top := lab.paddingTop
    
    //g.brush = Color.red
    //g.drawRect(left+2, top+2, lab.contentWidth-4, lab.contentHeight-4)
    
    //to center
    cx := left + (lab.contentWidth/2.toFloat).round.toInt
    cy := top + (lab.contentHeight/2.toFloat).round.toInt
    
    fontOffset := font.ascent + font.leading
    cy += (fontOffset/2.toFloat).toInt
    
    lineHeight := dpToPixel(lab.rowHeight)
    index := lab.offsetIndex.round.toInt
    viewOffset := (lab.offsetIndex - index) * lineHeight
    
    y := cy - viewOffset.toInt
    //echo("offsetIndex:${lab.offsetIndex}, y:${y}, cy:$y, viewOffset:$viewOffset")
    
    g.brush = fontColor
    r := 1f
    y -= lineHeight * 2
    maxOffset := lineHeight * 1.2
    curIndex := index - 2
    
    g.clip(Rect(0, 0, lab.width, lab.height))
    
    maxFontW := 0
    for (i:=0; i<5; ++i) {
      r = ((y - cy)/maxOffset.toFloat)
      g.push
      fontW := drawAt(lab, g, curIndex, cx, y, font, r)
      if (fontW > maxFontW) maxFontW = fontW
      g.pop
      y += lineHeight
      curIndex += 1
    }

    if (drawCursor) {
      maxFontW += dpToPixel(10)
      if (maxFontW < lineHeight) maxFontW = lineHeight

      px := cx - maxFontW/2
      py := (top + (lab.contentHeight/2.0) - (lineHeight/2.0) + 1).toInt
      arc := dpToPixel(8)
      g.drawRoundRect(px, py, maxFontW, lineHeight, arc, arc)
    }
  }
  
  private Int drawAt(Spinner widget, Graphics g, Int i1, Int cx, Int y, Font ofont, Float r) {
    if (i1 >= 0 && i1 < widget.items.size) {
       text := widget.items[i1]
       
       font := ofont.toSize(ofont.size - dpToPixel((r.abs*10).toInt))
       g.font = font
       fontW := font.width(text)
       w := fontW/2
       x := cx-w
       
       alpha := ((1-r.abs)*255).toInt
       if (alpha > 255) alpha = 255
       else if (alpha < 0) alpha = 0
       g.alpha = alpha
       
       //scale := (1-(r.abs*0.5))
//       trans := Transform2D().
//            translate(-x.toFloat, -y.toFloat).
//            shear(0.3*r, 0.0).
//            translate(x.toFloat, y.toFloat)
//       g.transform(trans)

       g.drawText(text, x, y)
       return fontW
    }
    return 0
  }
}
