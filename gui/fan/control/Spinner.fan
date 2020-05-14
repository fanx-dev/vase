// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-5 yangjiandong Creation
//

**
** Spinner
**
@Js
class Spinner : Widget
{
    Int selIndex := 0 {
      set {
        oldVal := &selIndex
        &selIndex = it
        fireStateChange(oldVal, it, #selIndex)
        offsetIndex = it.toFloat
      }
    }
    Str[] items := [,]
    
    @Transient
    protected Float offsetIndex := 0f
    
    Float lineHeight := 60f
    
    new make() {
        layout.width = Layout.wrapContent
        padding = Insets(20)
        focusable = true
        pressFocus = true
    }
    
    protected override Dimension prefContentSize() {
        w := dpToPixel(200f)
        h := dpToPixel(lineHeight)*4
        return Dimension(w, h)
    }
    
    private Void endMove() {
        i := offsetIndex.round.toInt
        if (i >= items.size) i = items.size-1
        else if (i < 0) i = 0
        selIndex = i
        this.repaint
    }
    
    protected override Void gestureEvent(GestureEvent e) {
        super.gestureEvent(e)
        if (e.consumed) return
        
        if (e.type == GestureEvent.drag) {
            r := e.deltaY.toFloat/dpToPixel(lineHeight)
            t := offsetIndex - r
            &offsetIndex = t
            e.consume
            this.repaint
        }
        else if (e.type == GestureEvent.drop) {
            endMove
            e.consume
            this.repaint
        }
        else if (e.type == GestureEvent.fling) {
            if (offsetIndex >= items.size.toFloat || offsetIndex < 0.0) {
                endMove
                return
            }
            
            toIndex := offsetIndex-(e.speedY.toFloat * 5)
            if (toIndex >= items.size.toFloat) toIndex = items.size.toFloat
            else if (toIndex < 0.0) toIndex = 0.0
            
            anim := Animation {
                it.duration = 500
                FloatPropertyAnimChannel(this, #offsetIndex) {
                  from = offsetIndex; to = toIndex
                },
            }
            anim.whenDone.add {
                endMove
            }
            this.getRootView.animManager.add(anim)
            anim.start
            this.repaint
        }
    }
}
