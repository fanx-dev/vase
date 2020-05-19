// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-05-03 Administrator Creation
//
using vaseWindow

**
** TabView
**
@Js
class TabsView : HBox
{
    Int selIndex := 0 {
      set {
        w := this.getChild(&selIndex)
        if (w != null) w.style = "tabItem"
        
        w2 := this.getChild(it)
        if (w2 != null) w2.style = "tabItemHighlight"
        
        oldVal := &selIndex
        &selIndex = it
        fireStateChange(oldVal, it, #selIndex)
        
        this.resetStyle
        this.repaint
      }
    }
    
    Void bind(CardPane card) {
        card.onStateChanged.add |StateChangedEvent e|{
            if (e.field == CardPane#selIndex) {
                this.selIndex = e.newValue
            }
        }
        this.onStateChanged.add |StateChangedEvent e|{
            if (e.field == TabsView#selIndex) {
                card.selIndex = e.newValue
            }
        }
    }
    
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
                    selIndex = i
                }
            }
            this.add(bt)
        }
        gestureFocusable = true
        clip = true
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
    if (e.consumed) return
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
