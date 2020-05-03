// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020Äê5ÔÂ3ÈÕ Administrator Creation
//
using vaseGraphics
using vaseWindow

**
** CardIndicatorStyle
**
class CardIndicatorStyle : WidgetStyle {
  override Void doPaint(Widget widget, Graphics g) {
    CardIndicator p := widget
    if (p.cardBox == null) return
    Int w := widget.contentWidth
    Int h := widget.contentHeight
    x := widget.paddingTop.toFloat
    y := widget.paddingLeft

    size := p.cardBox.childrenSize
    pw := (w.toFloat / p.cardBox.childrenSize)
    
    x += (pw/2)
    minW := pw.toInt.min(h)
    halfW := minW/2
    g.brush = foreground
    
    curX := (pw/2)+(p.cardBox.offsetIndex * pw)
    g.fillOval(curX.toInt-halfW, y, minW, minW)
    size.times |i| {
        g.drawOval(x.toInt-halfW, y, minW, minW)
        x += pw
    }
  }
}
