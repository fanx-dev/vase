// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-5 yangjiandong Creation
//
using vaseGraphics

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
    
    Int rowHeight := 60
    
    new make() {
        layout.width = Layout.wrapContent
        padding = Insets(20)
        focusable = true
    }
    
    protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
        w := dpToPixel(200)
        h := dpToPixel(rowHeight)*4
        return Size(w, h)
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
            r := e.deltaY.toFloat/dpToPixel(rowHeight)
            t := offsetIndex - r
            &offsetIndex = t
            e.consume
            this.repaint
        }
        else if (e.type == GestureEvent.drop) {
            if (offsetIndex >= items.size.toFloat || offsetIndex < 0.0) {
                endMove
                return
            }
            if (e.speedY.abs < 0.1) {
                endMove
                return
            }
            
            toIndex := offsetIndex-(e.speedY.toFloat * 4)
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
