// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-05-03 Administrator Creation
//

**
** TabView
**
class TabView : HBox
{
    Int selIndex := 0
    |Int|? onAction
    private Int offsetX = 0
    private Str[] items

    new make(Str[] items) {
        this.items = items
        items.each |item, i|{
            bt := Button {
                it.style = i == selIndex ? "tabItemHighlight" : "tabItem"
                it.text = item
                it.layout.width = Layout.wrapContent
                it.onClick {
                    onAction?.call(i)
                    this.getChild(selIndex).style = "tabItem"
                    selIndex = i
                    it.style = "tabItemHighlight"
                    this.resetStyle
                    this.repaint
                }
            }
            this.add(bt)
        }
    }
    
  override Void layoutChildren(Bool force)
  {
    super.layoutChildren(force)
    this.each |c| {
        c.x += offsetX
    }
  }
  
  protected override Void gestureEvent(GestureEvent e) {
    super.gestureEvent(e)
    
    if (e.type == GestureEvent.drag) {
        last := this.getChild(items.size-1)
        if (e.deltaX + last.x + last.width < this.contentWidth) {
            return
        }
        offsetX += e.deltaX
        if (offsetX > 0) offsetX = 0
        e.consume
        this.relayout
    }
  }
}
