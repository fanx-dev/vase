// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-4-27 yangjiandong Creation
//

**
** lays out child elements as a stack of cards
** where only one card may be visible at a time
**
class CardBox : Pane
{
  Int selIndex := 0 {
    set {
      if (it != &selIndex) select(it)
      &selIndex = it
    }
  }
  
  private Void select(Int i) {
    old := getChild(selIndex)
    old.enabled = false
    
    cur := getChild(i)
    cur.visible = true
    
    toLeft := i > selIndex

    outAnim := old.moveOutAnim(toLeft ? Direction.left : Direction.right, 500, false)
    outAnim.whenDone.add {
      old.visible = false
      cur.enabled = true
    }
    outAnim.start
    cur.moveInAnim(toLeft ? Direction.right : Direction.left , 500).start
    this.repaint
  }
  
  @Operator override This add(Widget child) {
    if (childrenSize > 0) {
        child.visible = false
        child.enabled = false
    }
    return super.add(child)
  }
}
