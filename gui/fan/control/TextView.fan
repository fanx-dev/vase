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
      sizeCache = null
      this.repaint
    }
  }
  
  @Transient
  private Str[] lines := [,]
  @Transient
  private Int lastWidth := 0
  @Transient
  private Bool textDirty := true
  @Transient
  private Int sizeCacheWidth := -1
  @Transient
  private Size? sizeCache := null

  
  Bool autoWrap := true
  
  protected Font font() {
    return getStyle.font(this)
  }
  
  Int rowHeight() { font.height }

  new make()
  {
    padding = Insets(1)
  }
  
  Str[] wrapText(Int w := contentWidth) {
    w = w-dpToPixel((padding.left + padding.right))

    if (!textDirty && lastWidth == w) {
        return lines
    }
    textDirty = false
    lastWidth = w
    
    lines = text.split('\n')
    if (!autoWrap || w <= 0) return lines
    
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
    end := 0
    for (; end<=line.size; ++end) {
        t := line[start..<end]
        if (font.width(t) > w && (end-1>start)) {
            end = end - 1
            t0 := line[start..<end]
            lines.add(t0)
            start = end
        }
    }
    if (start < line.size) {
        t0 := line[start..-1]
        lines.add(t0)
    }
    return lines
  }

  protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {

    if (sizeCache != null && sizeCacheWidth == hintsWidth) return sizeCache
    sizeCacheWidth = hintsWidth

    lines := wrapText(hintsWidth)
    w := 0
    lines.each {
       lw := font.width(it)
       w = w.max(lw)
    }
    h := rowHeight * lines.size

    //echo("prefSize:($w, $h), hintsWidth:$hintsWidth, $lines")
    sizeCache = Size(w, h)
    return sizeCache
  }
}