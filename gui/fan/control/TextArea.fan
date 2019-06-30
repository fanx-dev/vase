//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

@Js
class NativeCaret : Caret, TextInput {

  Int x
  Int y
  Int lineIndex := 0

  TextArea area

  new make(TextArea area) { this.area = area }

  override TextInputPeer? host

  override Point getPos() {
    c := Coord(0, 0)
    area.posOnWindow(c)
    return Point(c.x+x, c.y+y)
  }

  override Size getSize() { Size(0, area.rowHeight) }

  override Int inputType() { 1 }
  override Bool singleLine() { true }
  override Bool editable() { true }

  override Color textColor() { Color.blue }
  override Color backgroundColor() { Color.white }
  override Font font() { area.font }
  
  override Str text() { area.model.line(lineIndex) }

  override Str textChange(Str text) {
    area.model.modifyLine(lineIndex, text, false)
    area.repaint
    return text
  }
  override Void keyAction(Str text) {
    //TODO
  }
  override Void onKeyEvent(KeyEvent e) {
    echo("onKeyEvent: $e")
  }
}

**
** Text
**
@Js
class TextArea : ScrollBase
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
  }

  protected override Dimension prefContentSize(Dimension result) {
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
    return result.set(w, h)
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

  Int? updateCaretAtPos(Int x, Int y) {
    Int absX := x + offsetX
    Int absY := y + offsetY

    //echo("absX$absX,absY$absY,dx$offsetX,dy$offsetY")

    Int lineIndex := absY / rowHeight
    if (lineIndex >= model.lineCount) return null
    Int lineOffset := textIndex(model.line(lineIndex) , absX)

    caret.lineIndex = lineIndex
    caret.y = (lineIndex) * rowHeight
    caret.x = font.width(model.line(lineIndex)[0..<lineOffset])
    caret.offset = model.offsetAtLine(lineIndex) + lineOffset
    caret.visible = true
    this.getRootView.host?.textInput(caret)
    caret.host.select(lineOffset, lineOffset)

    return caret.offset
  }

  **
  ** Map a coordinate on the widget to an offset in the text,
  ** or return null if no mapping at specified point.
  **
  Int? offsetAtPos(Int x, Int y)
  {
    Int absX := x + offsetX
    Int absY := y + offsetY

    //echo("absX$absX,absY$absY,dx$offsetX,dy$offsetY")

    Int lineIndex := absY / rowHeight
    if (lineIndex >= model.lineCount) return null
    Int lineOffset := textIndex(model.line(lineIndex) , absX)
    return model.offsetAtLine(lineIndex) + lineOffset
  }

  Int textIndex(Str text, Int w)
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
      offset := updateCaretAtPos(sx, sy) ?: model.charCount
      selectionStart = offset
      draging = true
      //focus
      //this.repaint
      e.consume
    }
    else if (draging && e.type == MotionEvent.released)
    {
      offset := offsetAtPos(sx, sy) ?: model.charCount
      if (offset == selectionStart)
      {
        selectionStart = -1
        selectionEnd = -1
        draging = false
        this.repaint
        return
      }
      caret.offset = offset
      selectionEnd = offset

      //swap value
      if (selectionStart > selectionEnd)
      {
        temp := selectionStart
        selectionStart = selectionEnd
        selectionEnd = temp
      }
      this.repaint
      e.consume
    }
  }

  override Void keyEvent(KeyEvent e)
  {
    // remove text
    if (e.key == Key.backspace)
    {
      if (e.type == KeyEvent.pressed)
      {
        if (text.size == 0) return
        if (selectionStart >= 0 && selectionEnd >= 0)
        {
          model.modify(selectionStart, selectionEnd-selectionStart, "")
          selectionStart = -1
          selectionEnd = -1
          draging = false
          repaint
        }
        else if (caret.offset > 0)
        {
          --caret.offset
          model.modify(caret.offset, 1, "")

          repaint
        }
      }
      return
    }

    //typed
    if (e.type != KeyEvent.typed) return

    //skip ctrl char
    if (e.keyChar < 32) return

    model.modify(caret.offset, 0, e.keyChar.toChar)
    caret.offset++
    repaint
  }
}