using vaseWindow
using vaseGraphics

class ResizePane : Pane {
    Bool highlight = false
    internal Int mode = 0

    new make() {
        padding = Insets(20, 10, 10, 10)
    }

    protected override Void gestureEvent(GestureEvent e) {
        super.gestureEvent(e)
        //echo("e.consumed:$e.consumed,e.type:$e.type, mode:$mode")
        if (e.consumed) return

        if (e.type == GestureEvent.drag && mode != 0) {
            switch (mode) {
                case 1:
                    if (layout.offsetY + pixelToDp(e.deltaY) > 0) {
                        layout.offsetY += pixelToDp(e.deltaY)
                    }
                    layout.offsetX += pixelToDp(e.deltaX)
                    
                case 2:
                    layout.width += pixelToDp(e.deltaX)
                case 3:
                    layout.height += pixelToDp(e.deltaY)
                case 4:
                    layout.offsetX += pixelToDp(e.deltaX)
                    layout.width -= pixelToDp(e.deltaX)
            }
            e.consume
            relayout
        }
        else if (e.type == GestureEvent.drop && mode != 0) {
            relayout(2)
            mode = 0
        }
    }

    protected override Void motionEvent(MotionEvent e) {
        super.motionEvent(e)
        //echo("e.consumed:$e.consumed,e.type:$e.type")
        if (e.consumed) return
        
        if (e.type == MotionEvent.pressed) {
            getRootView?.gestureFocus(this)
        }
        else if (e.type == MotionEvent.released || e.type == MotionEvent.mouseOut || e.type == MotionEvent.cancel) {
            relayout(2)
            mode = 0
        }
        else if (e.type == MotionEvent.mouseMove) {

            if (e.relativeY < this.y+paddingTop) {
                mode = 1
            }
            else if (e.relativeY > this.y+paddingTop+contentHeight) {
                mode = 3
            }
            else if (e.relativeX > this.x + paddingLeft + contentWidth) {
                mode = 2
            }
            else if (e.relativeX < this.x + this.paddingLeft) {
                mode = 4
            }
            else {
                mode = 0
            }

            if (mode != 0 && !highlight) {
                getRootView?.mouseHover(this)
            }
        }
        if (highlight) {
            e.consume
        }
    }

    override Void mouseExit() {
        highlight = false
        repaint
    }

    override Void mouseEnter() {
        highlight = true
        repaint
    }
}