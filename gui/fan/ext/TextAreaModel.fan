//
// Copyright (c) 2008, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   28 Jul 08  Brian Frank  Creation
//

using vaseGraphics
using vaseWindow


**************************************************************************
** TextAreaModel
**************************************************************************

**
** TextAreaModel models the document and styling of a `TextArea` document.
**
@Js
abstract class TextAreaModel
{

  **
  ** Callback model generated when the text is modified.
  **
  ** Event id fired:
  **   - `EventId.modified`
  **
  ** Event fields:
  **   - `Event.data`: the `TextChange`.
  **
  once EventListeners onModify() { EventListeners() }

  **
  ** Get or set the entire text document.
  **
  abstract Str text

  **
  ** Return the number of characters in the content.
  **
  abstract Int charCount()

  **
  ** Return the number of lines.
  **
  abstract Int lineCount()

  **
  ** Return the line at the given zero based line index without delimiters.
  **
  abstract Str line(Int lineIndex)


  abstract Point posAtOffset(Int offset)

  **
  ** Return the zero based line index at the given character offset.
  **
  abstract Int lineAtOffset(Int offset)

  **
  ** Return the character offset of the first character of the
  ** given zero based line index.
  **
  abstract Int offsetAtLine(Int lineIndex)

  **
  ** Return the line delimiter that should be used when inserting
  ** new lines. The default is "\n".
  **
  virtual Str lineDelimiter() { return "\n" }

  //abstract Int maxWidth()
  //abstract Font font()

  **
  ** Returns a string representing the content at the given range.
  ** The default implementation of textRange is optimized to assume
  ** the backing store is based on lines.
  **
  virtual Str textRange(Int start, Int len)
  {
    // map offsets to line, if the offset is the line's
    // delimiter itself, then offsetInLine will be negative
    lineIndex := lineAtOffset(start)
    lineOffset := offsetAtLine(lineIndex)
    lineText := line(lineIndex)
    offsetInLine := start-lineOffset

    // if this is a range within a single line, then use normal Str slice
    if (offsetInLine+len <= lineText.size)
    {
      return lineText[offsetInLine..<offsetInLine+len]
    }

    // the range spans multiple lines
    buf := StrBuf(len)
    n := len

    // if the start offset is in the delimiter, then make sure
    // we start at next line, otherwise add the slice of the
    // first line to our buffer
    if (offsetInLine >= 0)
    {
      buf.add(lineText[offsetInLine..-1])
      n -= buf.size
    }

    // add delimiter of first line
    delimiter := lineDelimiter
    if (n > 0) { buf.add(delimiter);  n -= delimiter.size }

    // keep adding lines until we've gotten the full len
    while (n > 0)
    {
      lineText = line(++lineIndex)
      // full line (and maybe its delimiter)
      if (n >= lineText.size)
      {
        buf.add(lineText)
        n -= lineText.size
        if (n > 0) { buf.add(delimiter);  n -= delimiter.size }
      }
      // partial line
      else
      {
        buf.add(lineText[0..<n])
        break
      }
    }
    return buf.toStr
  }

  **
  ** Replace the text with 'newText' starting at position 'start'
  ** for a length of 'replaceLen'.  The model implementation must
  ** fire the `onModify` event.
  **
  abstract Void modify(Int start, Int replaceLen, Str newText)

  abstract Void modifyLine(Int lineIndex, Str? line, Bool add)

  **
  ** Return the styled segments for the given zero based line index.
  ** The result is a list of Int/RichTextStyle pairs where the Int
  ** specifies a zero based char offset of the line using a pattern
  ** such as:
  **
  **   [Int, RichTextStyle, Int, RichTextStyle, ...]
  **
  virtual Obj[]? lineStyling(Int lineIndex) { return null }

  **
  ** Return the color to use for the specified line's background.
  ** Normal lineStyling backgrounds only cover the width of the text.
  ** However, the lineBackground covers the width of the entire
  ** edit area.  Return null for no special background.
  **
  virtual Color? lineBackground(Int lineIndex) { return null }
}

@Js
class DefTextAreaModel : TextAreaModel
{
  private Str[] lines := [,]

  new make(Str text)
  {
    this.text = text
  }

  **
  ** Get or set the entire text document.
  **
  override Str text
  {
    set
    {
      lines = it.splitLines
    }
    get {
      lines.join("\n")
    }
  }

  **
  ** Return the number of characters in the content.
  **
  override Int charCount() {
    s := 0
    lines.each { s += it.size }
    return s
  }

  **
  ** Return the number of lines.
  **
  override Int lineCount() { lines.size }

  **
  ** Return the line at the given zero based line index without delimiters.
  **
  override Str line(Int lineIndex) { lines[lineIndex] }

  **
  ** Return the zero based line index at the given character offset.
  **
  override Int lineAtOffset(Int offset)
  {
    Int count := 0
    n := lines.size
    for (i:=0; i<n; ++i)
    {
      if (offset < count + lines[i].size + 1)
      {
        return i
      }
      count += lines[i].size + 1
    }
    return n
  }

  override Point posAtOffset(Int offset) {
    Int count := 0
    n := lines.size
    for (i:=0; i<n; ++i)
    {
      if (offset < count + lines[i].size + 1)
      {
        y := i
        x := offset - count
        return Point(x, y)
      }
      count += lines[i].size + 1
    }
    if (n == 0) return Point(0, 0)
    return Point(lines[n-1].size, n-1)
  }

  **
  ** Return the character offset of the first character of the
  ** given zero based line index.
  **
  override Int offsetAtLine(Int lineIndex)
  {
    Int count := 0
    for (i:=0; i<lineIndex; ++i)
    {
      count += lines[i].size + 1
    }
    return count
  }

  /*
  override Int maxWidth()
  {
    Int max := 0
    Int maxIndex := 0
    n := lines.size
    for (i:=0; i<n; ++i)
    {
      if (max < lines[i].size)
      {
        max = lines[i].size
        maxIndex = i
      }
    }
    return font.width(lines[maxIndex])
  }*/

  override Void modifyLine(Int lineIndex, Str? line, Bool add) {
    if (line == null) {
      lines.removeAt(lineIndex)
    }
    else if (add) {
      lines.insert(lineIndex, line)
    }
    else {
      lines[lineIndex] = line
    }
  }

  **
  ** Replace the text with 'newText' starting at position 'start'
  ** for a length of 'replaceLen'.  The model implementation must
  ** fire the `onModify` event.
  **
  override Void modify(Int start, Int replaceLen, Str newText)
  {
    //echo("modify $start $replaceLen, $newText")
    sp := posAtOffset(start)

    if (replaceLen == 0 && newText == "\n") {
      line := lines[sp.y]
      if (line.size == sp.x) {
        lines.insert(sp.y+1, "")
        return
      }
      line1 := line[0..<sp.x]
      line2 := line[sp.x..-1]
      lines[sp.y] = line1
      lines.insert(sp.y+1, line2)
      return
    }

    addLines := newText.split
    if (replaceLen == 0 && addLines.size == 1) {
      line := lines[sp.y]
      line = line[0..<sp.x] + newText + line[sp.x..-1]
      lines[sp.y] = line
      return
    }

    ep := posAtOffset(start+replaceLen)
    
    newLines := Str[,]
    Str? tempText := null
    for (i:=0; i<lines.size; ++i) {
      if (i<sp.y) {
        newLines.add(lines[i])
        continue
      }
      if (i == sp.y) {
        nline := lines[i][0..<sp.x] + addLines[0]
        if (addLines.size <= 1) {
          tempText = nline
        }
        else {
          newLines.add(nline)
          for (j:=1; j<addLines.size-1; ++j) {
            newLines.add(addLines[j])
          }
          tempText = addLines.last
        }        
      }
      if (i == ep.y) {
        nline := lines[i][ep.x..-1]
        if (tempText != null) nline = tempText + nline
        newLines.add(nline)
        continue
      }
      else if (i > ep.y) {
        newLines.add(lines[i])
        continue
      }
    }

    lines = newLines
  }
}

**************************************************************************
** RichTextStyle
**************************************************************************

**
** Defines the font and color styling of a text
** segment in a `RichTextModel`.
**
@Js
@Serializable
class RichTextStyle
{
  **
  ** Default constructor.
  **
  new make(|This|? f := null)
  {
    if (f != null) f(this)
  }

  ** Foreground color
  const Color? fg

  ** Background color or null
  const Color? bg

  ** Font of text segment
  Font? font

  ** Underline color, if null then use fg color.
  const Color? underlineColor

  ** Underline style or none for no underline.
  ** none,single,squiggle
  const Int underline := 0

  override Str toStr()
  {
    s := StrBuf()
    if (fg != null) s.add("fg=$fg")
    if (bg != null) s.add(" bg=$bg")
    if (font != null) s.add(" font=$font")
    if (underline != 0) s.add(" underline=$underline")
    if (underlineColor != null) s.add(" underlineColor=$underlineColor")
    return s.toStr.trim
  }
}
