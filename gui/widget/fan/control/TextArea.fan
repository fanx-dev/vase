//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using fgfx2d
using fgfxWtk


**
** Text
**
@Js
class TextArea : Scroller
{
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
  TextAreaModel? model
  {
    set
    {
      old := this.&model
      if (old != null) old.onModify.remove(onModelModifyFunc)
      if (it != null) it.onModify.add(onModelModifyFunc)
      this.&model = it
    }
  }

  private |Event| onModelModifyFunc := |e| { onModelModify(e) }
  protected virtual Void onModelModify(Event event) {}

  **
  ** Tab width measured in space characters.  Default is 2.
  **
  Int tabSpacing := 2

  **
  ** Convenience for 'model.text' (model must be installed).
  **
  Str text
  {
    get { return model.text }
    set { model.text = it }
  }

  Int rowHeight := 20
  Caret caret := Caret()

  new make(TextAreaModel model)
  {
    this.model = model
  }

  protected override Int contentWidth() { model.maxWidth }

  protected override Int contentHeight()
  {
    model.lineCount * rowHeight
  }

//////////////////////////////////////////////////////////////////////////
// Utils
//////////////////////////////////////////////////////////////////////////

  **
  ** Map a coordinate on the widget to an offset in the text,
  ** or return null if no mapping at specified point.
  **
  Int? offsetAtPos(Int x, Int y)
  {
    Int absX := x + offsetX
    Int absY := y + offsetY

    Int lineIndex := absY / rowHeight
    Int lineOffset := textIndex(model.line(lineIndex) , absX)
    return model.offsetAtLine(lineIndex) + lineOffset
  }

  Int textIndex(Str text, Int w)
  {
    Int size := text.size
    for (i := 0; i<size; ++i)
    {
      Int tw := model.font.width(text[0..<i+1])
      if (tw > w) return i
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

  override Void touch(MotionEvent e)
  {
    super.touch(e)
    if (e.consumed) return

    p := mapToRelative(Point(e.x, e.y))
    if (this.bounds.contains(p.x, p.y))
    {
      if (e.id == MotionEvent.pressed)
      {
        offset := offsetAtPos(p.x, p.y)
        caret.offset = offset
        caret.visible = true
        focus
        this.repaint
      }
    }
  }

  override Void keyPress(KeyEvent e)
  {
    if (e.key == Key.backspace)
    {
      if (e.id == KeyEvent.pressed)
      {
        if (text.size > 0 && caret.offset > 0)
        {
          --caret.offset
          model.modify(caret.offset, 1, "")

          repaint
        }
      }
      return
    }

    if (e.id != KeyEvent.typed) return

    if (e.keyChar < 32) return

    model.modify(caret.offset, 0, e.keyChar.toChar)
    caret.offset++
    repaint
  }
}