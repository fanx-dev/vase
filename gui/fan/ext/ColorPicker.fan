
using vaseWindow
using vaseGraphics

internal class ColorLine : Widget {
    Float value = 180.0
    Int step = dpToPixel(5)

    protected override Void doPaint(Rect clip, Graphics g) {
        w := this.contentWidth
        h := this.contentHeight
        ox := this.paddingLeft
        oy := this.paddingTop
        g.lineWidth = step.toFloat+1.0
        for (i := 0; i<w; i+=step) {
            v := i  * 360.0 / w
            g.brush = Color.makeHsv(v, 1.0, 1.0)
            g.drawLine(ox+i, oy, ox+i, h)
        }

        g.lineWidth = dpToPixel(2).toFloat
        g.brush = Color.black
        x := (value / 360.0 * w).toInt
        g.drawLine(ox+x, 0, ox+x, h)
    }

    protected override Void motionEvent(MotionEvent e) {

        if (e.type == MotionEvent.released || e.type == MotionEvent.moved) {
            w := this.contentWidth
            h := this.contentHeight
            ox := this.paddingLeft

            value = (e.relativeX-x-ox) * 360.0 / w
            value = value.clamp(0.0, 360.0)
            (parent as ColorPicker).update
        }
    }
}

internal class ColorRect : Widget {
    Float valueX = 0.0
    Float valueY = 0.0
    ColorLine? colorLine
    Int step = dpToPixel(5)

    protected override Void doPaint(Rect clip, Graphics g) {
        w := this.contentWidth
        h := this.contentHeight
        ox := this.paddingLeft
        oy := this.paddingTop

        hstep := step / 2

        g.lineWidth = 1.0
        for (i := 0; i<w; i+=step) {
            vx := i / w.toFloat
            for (j := 0; j<h; j+=step) {
                vy := j / h.toFloat
                g.brush = Color.makeHsv(colorLine.value, vx, vy)
                g.fillRect(ox+i-hstep, oy+j-hstep, step+1, step+1)
            }
        }

        g.lineWidth = 1.0
        g.brush = Color.black
        x := (valueX * w).toInt
        y := (valueY * h).toInt
        offsize := dpToPixel(7)
        g.drawRect(ox+x-offsize, oy+y-offsize, offsize+offsize, offsize+offsize)
    }

    protected override Void motionEvent(MotionEvent e) {
        if (e.type == MotionEvent.released || e.type == MotionEvent.moved) {
            w := this.contentWidth
            h := this.contentHeight
            ox := this.paddingLeft
            oy := this.paddingTop
            valueX = (e.relativeX - x - ox) / w.toFloat
            valueY = (e.relativeY - y - oy) / h.toFloat
            valueX = valueX.clamp(0.0, 1.0)
            valueY = valueY.clamp(0.0, 1.0)
            (parent as ColorPicker).update
        }
    }
}

class ColorPicker : VBox {
    Color color {
        set {
            &color = it
            colorLine.value = it.h
            colorRect.valueX = it.s
            colorRect.valueY = it.v
            (rectView.inlineStyle as RectViewStyle).background = it
        }
    }

    private ColorLine colorLine
    private ColorRect colorRect
    private RectView rectView
    private Label label

    |Color|? onColorChanged

    new make() {
        layout.width = Layout.wrapContent
        layout.height = Layout.wrapContent

        inlineStyle = PaneStyle {}
        
        colorLine = ColorLine { it.layout.width = 700; it.layout.height = 120; it.padding = Insets(14) }
        colorRect = ColorRect { it.layout.width = 700; it.layout.height = 700; it.padding = Insets(14) }
        colorRect.colorLine = colorLine
        add(colorLine)
        add(colorRect)

        add(label = Label { it.layout.width = 700; it.padding = Insets(0, 14) })
        rectView = RectView { it.layout.width = 700; it.layout.height = 150; it.inlineStyle = RectViewStyle{}; it.padding = Insets(14) }
        add(rectView)

        color = Color(0x33b5e5)
    }

    internal Void update() {
        &color = Color.makeHsv(colorLine.value, colorRect.valueX, colorRect.valueY)
        label.text = color.toStr
        (rectView.inlineStyle as RectViewStyle).background = color

        onColorChanged?.call(color)
        this.repaint
    }
}