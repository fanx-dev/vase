// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-5 yangjiandong Creation
//

using vaseGraphics

**
** TextView
**
@Js
class TextView : Widget
{
  Str text := "" {
    set {
      &text = it
      textDirty = true
      this.repaint
    }
  }
  
  @Transient
  private Str[] lines := [,]
  @Transient
  private Int lastWidth := 0
  @Transient
  private Bool textDirty := false
  
  Bool autoWrap := true
  
  protected Font font() {
    return getStyle.font
  }
  
  Int rowHeight() { font.height }

  new make()
  {
  }
  
  Str[] wrapText() {
    w := contentWidth
    if (textDirty == false && lastWidth == w) return lines
    lastWidth = w
    
    lines = text.split('\n')
    if (!autoWrap) return lines
    
    nlines := Str[,]
    for (i:=0; i<lines.size; ++i) {
        ls := wrapLine(lines[i], w)
        if (ls != null) {
            nlines.addAll(ls)
        }
        else
            nlines.add(lines[i])
    }
    lines = nlines
    return lines
  }
  
  private Str[]? wrapLine(Str line, Int w) {
    aw := font.width(line)
    if (aw <= w) {
        return null
    }
    lines := Str[,]
    start := 0
    i := 0
    for (; i<line.size; ++i) {
        t := line[start..i]
        if (font.width(t) > w && (i-1>start)) {
            t0 := line[start..i-1]
            lines.add(t0)
            start = i
        }
    }
    if (start < line.size-1) {
        t0 := line[start..-1]
        lines.add(t0)
    }
    return lines
  }

  protected override Dimension prefContentSize() {
    lines := text.split('\n')
    w := 0
    lines.each {
       lw := font.width(it)
       w = w.max(lw)
    }
    h := rowHeight * lines.size
    return Dimension(w, h)
  }
}