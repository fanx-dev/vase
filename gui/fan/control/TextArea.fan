//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class NativeCaret : Caret, TextInput {

  Int x
  Int y

  Int lineIndex := 0

  TextArea area

  new make(TextArea area) { this.area = area }

  override TextInputPeer? host
/*
  override Point getPos() {
    c := Coord(0, 0)
    area.posOnWindow(c)
    return Point(c.x+x, c.y+y)
  }
  override Size getSize() { Size(1, area.rowHeight) }

  override Int inputType() { 1 }
  override Bool singleLine() { true }
  override Bool editable() { true }

  override Color textColor() { Color.blue }
  override Color backgroundColor() { Color.white }
  override Font font() { area.font }
*/

  internal Void updateHost(Bool all := true) {
    if (host == null) return

    if (!all) {
      c := Coord(0f, 0f)
      area.posOnWindow(c)
      host.setPos(c.x.toInt+x, c.y.toInt+y, 1, area.rowHeight)
      return
    }

    host.setType(0, 0, true)

    c := Coord(0f, 0f)
    area.posOnWindow(c)
    host.setPos(c.x.toInt+x, c.y.toInt+y, 1, area.rowHeight)

    host.setStyle(area.font, Color.black, Color.white)
    host.setText(text)
    host.select(this.offset, this.offset)
    host.focus
  }
  
  private Str text() { area.model.line(lineIndex) }

  override Str textChange(Str text) {
    area.model.modifyLine(lineIndex, text, false)
    area.repaint
    return text
  }
  override Void keyAction(Str text) {
    //TODO
  }
  override Void onKeyEvent(KeyEvent e) {
    area.keyEvent(e)
  }
}

**
** Text
**
@Js
class TextArea : ScrollPane
{
  **
  ** Tab width measured in space characters.
  **
  Int tabSpacing := 4

  **
  ** Convenience for 'model.text' (model must be installed).
  **
  Str text
  {
    get { return model.text }
    set { model.text = it }
  }


  Int rowHeight() { font.height }

  @Transient
  NativeCaret caret := NativeCaret(this) { private set }

  internal Font font() {
    getStyle.font
  }


  ** Inclusive start position
  Int selectionStart := -1

  ** Exclusive end position
  Int selectionEnd := -1

  @Transient
  private Bool draging := false

  new make(|This|? f := null)
  {
    if (f != null) f(this)
    super.autoScrollContent = false
  }

  protected override Dimension prefContentSize() {
    Int h := model.lineCount * rowHeight

    Int max := 0
    Int maxIndex := 0
    n := model.lineCount
    for (i:=0; i<n; ++i)
    {
      line := model.line(i)
      if (max < line.size)
      {
        max = line.size
        maxIndex = i
      }
    }
    w := font.width(model.line(maxIndex))
    return Dimension(w, h)
  }

//////////////////////////////////////////////////////////////////////////
// Out Event
//////////////////////////////////////////////////////////////////////////

  **
  ** Callback when the text is modified.  This event occurs
  ** after the modification.  See `onVerify` to trap changes
  ** before they occur.
  **
  ** Event id fired:
  **   - `EventId.modified`
  **
  ** Event fields:
  **   - `Event.data`: the `TextChange` instance.
  **
  once EventListeners onModify() { EventListeners() }

  **
  ** Callback before the text is modified.  This gives listeners
  ** a chance to intercept modifications and potentially modify
  ** the inserted text.  This event occurs before the modification.
  ** See `onModify` to trap changes after they occur.
  **
  ** Event id fired:
  **   - `EventId.verify`
  **
  ** Event fields:
  **   - `Event.data`: a `TextChange` instance where 'newText'
  **     specifies the proposed text being inserted.  The callback
  **     can update 'newText' with the actual text to be inserted
  **     or set to null to cancel the modification.
  **
  once EventListeners onVerify() { EventListeners() }

  **
  ** Callback before a key event is processed.  This gives listeners
  ** a chance to trap the key event and [consume]`Event.consume`
  ** it before it is processed by the editor.
  **
  ** Event id fired:
  **   - `EventId.verifyKey`
  **
  ** Event fields:
  **   - `Event.keyChar`: unicode character represented by key event
  **   - `Event.key`: key code including the modifiers
  **
  once EventListeners onVerifyKey() { EventListeners() }

  **
  ** Callback when the selection is modified.
  **
  ** Event id fired:
  **   - `EventId.select`
  **
  ** Event fields:
  **   - `Event.offset`: the starting offset
  **   - `Event.size`:   the number of chars selected
  **
  once EventListeners onSelect() { EventListeners() }

  **
  ** Callback when the caret position is modified.
  **
  ** Event id fired:
  **   - `EventId.caret`
  **
  ** Event fields:
  **   - `Event.offset`: the new caret offset
  **
  once EventListeners onCaret() { EventListeners() }

 **
  ** Backing data model of text document.
  ** The model cannot be changed once the widget has been
  ** been mounted into an open window.
  **
  @Transient
  TextAreaModel? model := DefTextAreaModel("")
  {
    set
    {
      old := this.&model
      if (old != null) old.onModify.remove(onModelModifyFunc)
      if (it != null) it.onModify.add(onModelModifyFunc)
      this.&model = it
    }
  }

  @Transient
  private |Event| onModelModifyFunc := |e| { onModelModify(e) }
  protected virtual Void onModelModify(Event event) {}

//////////////////////////////////////////////////////////////////////////
// Utils
//////////////////////////////////////////////////////////////////////////

  private Int? updateCaretByCoord(Int x, Int y) {
    Int absX := x + offsetX
    Int absY := y + offsetY

    //echo("absX$absX,absY$absY,dx$offsetX,dy$offsetY")

    Int lineIndex := absY / rowHeight
    if (lineIndex >= model.lineCount) return null
    Int lineOffset := textIndexAtPos(model.line(lineIndex) , absX)

    updateCaretAt(lineIndex, lineOffset)

    return model.offsetAtLine(lineIndex) + lineOffset
  }

  protected override Void doPaint(Graphics g) {
    //update caret pos before paint
    if (caret.host != null) {
      caretPos := caret.host.caretPos
      if (caret.offset != caretPos) {
        echo("reset caret: $caret.offset to $caretPos")
        updateCaretAt(caret.lineIndex, caretPos, true, false)
      }
    }
    super.doPaint(g)
  }

  private Void updateCaretAt(Int row, Int column, Bool clipColumn := true, Bool updateAll := true) {
    //echo("updateCaretAt row $row column $column")

    if (row < 0) row = 0
    else if (row >= model.lineCount) row = model.lineCount-1

    if (clipColumn) {
      if (column < 0) column = 0
      else if (column > model.line(row).size) column = model.line(row).size
    }
    else {
      if (column == -1) {
        --row
        if (row < 0) row = 0
        column = model.line(row).size
      }
      if (column > model.line(row).size) {
        if (row < model.lineCount-1) {
          ++row
          column = 0
        }
        else if (column > 0) {
          --column
        }
      }
    }

    echo("row $row column $column ${model.line(row)}")

    caret.lineIndex = row
    caret.y = (row) * rowHeight
    caret.x = font.width(model.line(row)[0..<column])
    //caret.offset = model.offsetAtLine(row) + column
    caret.visible = true
    caret.offset = column

    this.getRootView.host?.textInput(caret)
    caret.updateHost(updateAll)
    //echo("updateCaretAt: $row, $column")
    //Err().trace
    //caret.host.select(column, column)
  }

  **
  ** Map a coordinate on the widget to an offset in the text,
  ** or return null if no mapping at specified point.
  **
  private Int? offsetAtPos(Int x, Int y)
  {
    Int absX := x + offsetX
    Int absY := y + offsetY

    //echo("absX$absX,absY$absY,dx$offsetX,dy$offsetY")

    Int lineIndex := absY / rowHeight
    if (lineIndex >= model.lineCount) return null
    Int lineOffset := textIndexAtPos(model.line(lineIndex) , absX)
    return model.offsetAtLine(lineIndex) + lineOffset
  }

  private Int textIndexAtPos(Str text, Int w)
  {
    Int size := text.size
    for (i := 0; i<size; ++i)
    {
      Int tw := font.width(text[0..<i+1])
      if (tw > w) {
        //echo(text[0..<i+1] + ":tw$tw, w$w")
        return i
      }
    }
    return size
  }

  Bool hasSelected() {
    selectionStart != selectionEnd && selectionStart != -1 && selectionEnd != -1
  }

//////////////////////////////////////////////////////////////////////////
// Painting
//////////////////////////////////////////////////////////////////////////

  **
  ** Ensure the editor is scrolled such that the specified line is visible.
  **
  Void showLine(Int lineIndex)
  {

  }

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

  protected override Void motionEvent(MotionEvent e)
  {
    super.motionEvent(e)
    if (e.consumed) return

    sx := e.relativeX - this.x
    sy := e.relativeY - this.y
    if (e.type == MotionEvent.pressed)
    {
      //echo("e.x$e.x,e.y$e.y")
      clearSelected
      offset := updateCaretByCoord(sx, sy) ?: model.charCount
      selectionStart = offset
      draging = true
      //if (caret.host != null) caret.host.update
      //focus
      this.repaint
      e.consume
    }
    else if (draging)
    {
      if (e.type == MotionEvent.moved) {
        selectionEnd = offsetAtPos(sx, sy) ?: model.charCount

        //swap value
        if (selectionStart > selectionEnd)
        {
          temp := selectionStart
          selectionStart = selectionEnd
          selectionEnd = temp
        }

        this.repaint
        //echo("move: $selectionStart, $selectionEnd")
        e.consume
      }
      if (e.type == MotionEvent.released) {
        //updateCaretByCoord(sx, sy)
        if (caret.host != null) {
          caret.updateHost
          //caret.host.select(caret.offset, caret.offset)
        }
        draging = false
        e.consume
        this.repaint
      }
    }
    else if (e.type == MotionEvent.released) {
      //updateCaretByCoord(sx, sy)
      if (caret.host != null) {
        caret.updateHost
        //caret.host.select(caret.offset, caret.offset)
      }
      draging = false
    }
  }

  private Void clearSelected() {
    selectionStart = -1
    selectionEnd = -1
  }

  override Void keyEvent(KeyEvent e)
  {
    echo(e)
    if (e.type == KeyEvent.pressed) {
      //echo(e.key)
      if (e.key == Key.left) {
        updateCaretAt(caret.lineIndex, caret.offset-1, false)
        clearSelected
        this.repaint
        e.consume
        return
      }
      else if (e.key == Key.right) {
        updateCaretAt(caret.lineIndex, caret.offset+1, false)
        clearSelected
        this.repaint
        e.consume
        return
      }
      else if (e.key == Key.down) {
        updateCaretAt(caret.lineIndex+1, caret.offset)
        clearSelected
        this.repaint
        e.consume
        return
      }
      else if (e.key == Key.up) {
        updateCaretAt(caret.lineIndex-1, caret.offset)
        clearSelected
        this.repaint
        e.consume
        return
      }
      //new line
      else if (e.key == Key.enter) {
        if (hasSelected) {
          model.modify(selectionStart, selectionEnd-selectionStart, "\n")
        }
        else {
          pos := model.offsetAtLine(caret.lineIndex) + caret.offset
          model.modify(pos, 0, "\n")
        }
        updateCaretAt(caret.lineIndex+1, 0)
        clearSelected
        this.repaint
        e.consume
        return
      }
      //copy
      else if (e.key.primary == Key.c && e.key.isCtrl) {
        //echo("copy")
        if (hasSelected) {
          Toolkit.cur.clipboard.setText(model.textRange(selectionStart, selectionEnd-selectionStart))
        }
        e.consume
        return
      }
      //paste
      else if (e.key.primary == Key.v && e.key.isCtrl) {
        //echo("paste")
        if (hasSelected) {
          model.modify(selectionStart, selectionEnd-selectionStart, "")
          clearSelected
        }

        Toolkit.cur.clipboard.getText |text|{
          if (text == null) lret
          pos := model.offsetAtLine(caret.lineIndex) + caret.offset
          model.modify(pos, 0, text)
          this.repaint
        }
        e.consume
        return
      }
      else if (!e.key.hasModifier) {
        if (hasSelected) {
          model.modify(selectionStart, selectionEnd-selectionStart, "")
          clearSelected
          this.repaint
          e.consume
        }
      }
      
    }
  }
}
