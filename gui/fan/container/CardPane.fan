// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-4-27 yangjiandong Creation
//

using vaseWindow
using vaseGraphics

**
** lays out child elements as a stack of cards
** where only one card may be visible at a time
**
@Js
class CardPane : Pane
{
  Int selIndex := 0 {
    set {
      if (it.toFloat != &offsetIndex) select(it, false)
      oldVal := &selIndex
      &selIndex = it
      fireStateChange(oldVal, it, #selIndex)
    }
  }
  
  @Transient
  protected Float offsetIndex := 0f {
    set {
      if (&offsetIndex != it) {
        this.relayout
      }
      &offsetIndex = it
    }
  }
  
  Float pageWidthScale := 0.4
  
  new make() {
    gestureFocusable = true
    clip = true
  }
  
  private Void select(Int i, Bool updateWhenDone := true) {
    stdIndex := i
    if (stdIndex < 0) {
        stdIndex = this.childrenSize-1
    }
    if (stdIndex >= this.childrenSize) {
        stdIndex = 0
    }
    
    fromIndex := offsetIndex
    endIndex := i.toFloat
    if (i >= this.childrenSize) {
        endIndex = 0f
    }
    if (selIndex == this.childrenSize-1 && i == 0) {
       if (fromIndex > 0.0) {
         fromIndex = -1.0
       }
    }
    if (selIndex == 0 && i == this.childrenSize-1) {
       if (endIndex > 0.0) {
         endIndex = -1.0
       }
    }
    
    //echo("from$fromIndex -> to:$endIndex, std:$stdIndex")
    
    anim := Animation {
      it.duration = 300
      FloatPropertyAnimChannel(this, #offsetIndex) {
        from = fromIndex; to = endIndex
      },
    }
    anim.whenDone.add {
        this.&offsetIndex = stdIndex.toFloat
        if (updateWhenDone) this.selIndex = stdIndex
    }
    this.getRootView.animManager.add(anim)
    anim.start
    this.relayout
  }
  
  protected override Void gestureEvent(GestureEvent e) {
    super.gestureEvent(e)
    if (e.consumed) return
    
    if (e.type == GestureEvent.drag) {
        r := e.deltaX.toFloat/width
        t := offsetIndex - r
        if (t > (childrenSize-1).toFloat) {
            t = (t - (childrenSize-1)) - 1
            //echo(t)
        }
        &offsetIndex = t
        e.consume
        this.relayout
    }
    else if (e.type == GestureEvent.drop) {
        //echo("offsetIndex:$offsetIndex, selIndex:$selIndex")
        offsetIndex := this.offsetIndex
        if (offsetIndex < 0f && selIndex == (childrenSize-1)) {
            offsetIndex = (1+this.offsetIndex) + (childrenSize-1)
        }
        
        if ((offsetIndex-selIndex).abs < 0.01) select(selIndex)
        else if (offsetIndex > selIndex.toFloat) select(selIndex + 1)
        else if (offsetIndex < selIndex.toFloat) select(selIndex - 1)
        e.consume
        this.relayout
    }
  }
  
  override Void layoutChildren(Bool force)
  {
    super.layoutChildren(force)
    pageWidth := this.width * pageWidthScale
    this.each |Widget c, i|
    {
        dscale := 1.0
        if (i == childrenSize-1 && offsetIndex < 0f) {
            pageOffset := -(1+offsetIndex) * pageWidth
            c.x += pageOffset.toInt
            //echo("offsetIndex:$offsetIndex, $c.x")
            dscale = 0.1/((childrenSize+offsetIndex)-i).abs + 0.3
        }
        else {
            pageOffset := (i-offsetIndex) * pageWidth
            c.x += pageOffset.toInt
            
            if ((offsetIndex-i).abs <= 0.1) {
                c.transform = null
            }
            else {
                dscale = 0.1/(offsetIndex-i).abs + 0.3
            }
        }
        
        x := c.width /2.0f
        y := c.height /2.0f
        //dscale := 0.1/(offsetIndex-i).abs + 0.3

        if (dscale > 0.9) {
            c.transform = null
        }
        else {
            c.transform = Transform2D.makeTranslate(x, y) *
                             Transform2D.makeScale(dscale, dscale) * 
                             Transform2D.makeTranslate(-x, -y)
        }
    }
  }
}

@Js
class CardIndicator : Widget {
    CardPane? cardBox
    new make() {
        layout.height = 30
    }
}