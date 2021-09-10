//
// Copyright (c) 2008, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   16 Jun 08  Brian Frank  Creation
//

**
** Font models the rendering of text.
**
@Js
@Serializable { simple = true }
const abstract class Font
{

//////////////////////////////////////////////////////////////////////////
// Construction
//////////////////////////////////////////////////////////////////////////

  protected new privateMake(|This| f) { f(this) }

  **
  ** Construct a Font with family name, size in points, and optional
  ** bold/italic style.  This is internal for now, because eventually
  ** we should be able to collapse this and it-block into single ctor.
  **
  static new make(Int size := 12, Str name := "Arial", Bool bold := false, Bool italic := false)
  {

    func := Field.makeSetFunc([#name:name, #size:size, #bold:bold, #italic:italic])
    font := GfxEnv.cur.makeFont(func)
    // {
    //   it.name = name
    //   it.size   = size
    //   it.bold   = bold
    //   it.italic = italic
    // }
    return font
  }

  **
  ** Parse font from string (see `toStr`).  If invalid
  ** and checked is true then throw ParseErr otherwise
  ** return null.
  **
  ** Examples:
  **   Font.fromStr("12pt Arial")
  **   Font.fromStr("bold 10pt Courier")
  **   Font.fromStr("bold italic 8pt Times Roman")
  **
  static Font? fromStr(Str s, Bool checked := true)
  {
    try
    {
      Str? name := null
      Int? size := null
      bold   := false
      italic := false

      toks := s.split
      for (i:=0; i<toks.size; ++i)
      {
        tok := toks[i]
        if (tok == "bold") bold = true;
        else if (tok == "italic") italic = true
        else if (size != null) name = name == null ? tok : "$name $tok"
        else if (!tok.endsWith("pt")) throw Err()
        else size = tok[0..-3].toInt
      }

      return make(size.toInt, name, bold, italic)
    }
    catch {}
    if (checked) throw ParseErr("Invalid Font: $s")
    return null
  }

//////////////////////////////////////////////////////////////////////////
// Font
//////////////////////////////////////////////////////////////////////////

  **
  ** Name of font.
  **
  const Str name := "Serif"

  **
  ** Size of font in points.
  **
  const Int size := 11

  **
  ** Is this font bold.
  **
  const Bool bold

  **
  ** Is this font in italic.
  **
  const Bool italic

//////////////////////////////////////////////////////////////////////////
// Identity
//////////////////////////////////////////////////////////////////////////

  **
  ** Free any operating system resources used by this font.
  ** Dispose is required if this color has been used in an operation
  ** such as FWT onPaint which allocated a system resource to
  ** represent this instance.
  **
  abstract Void dispose()

  **
  ** Return hash of name, size, and style.
  **
  override Int hash()
  {
    hash := name.hash.xor(size)
    if (bold) hash *= 73
    if (italic) hash *= 19
    return hash
  }

  **
  ** Equality is based on name, size, and style.
  **
  override Bool equals(Obj? that)
  {
    x := that as Font
    if (x == null) return false
    return name == x.name &&
           size == x.size &&
           bold == x.bold &&
           italic == x.italic
  }

  **
  ** Format as '"[bold] [italic] <size>pt <name>"'
  **
  override Str toStr()
  {
    s := StrBuf()
    if (bold) s.add("bold")
    if (italic)
    {
      if (!s.isEmpty) s.add(" ")
      s.add("italic")
    }
    if (!s.isEmpty) s.add(" ")
    s.add(size).add("pt ").add(name)
    return s.toStr
  }

//////////////////////////////////////////////////////////////////////////
// Utils
//////////////////////////////////////////////////////////////////////////

  **
  ** Return this font, but with the specified point size.
  ** If thsi font already has the given size return this.
  **
  Font toSize(Int size)
  {
    if (this.size == size) return this
    return Font.make(size, name, bold, italic)
  }

  **
  ** Return this font, but with a plain styling (neither
  ** bold, nor italic).  If this font is already plain
  ** then return this.
  **
  Font toPlain()
  {
    if (!bold && !italic) return this
    return Font.make(size, name, false, false)
  }

  **
  ** Return this font, but with a bold styling.  If
  ** this font is already bold then return this.
  **
  Font toBold()
  {
    if (bold) return this
    return Font.make(size, name, true, italic)
  }

  **
  ** Return this font, but with a italic styling.  If
  ** this font is already italic then return this.
  **
  Font toItalic()
  {
    if (italic) return this
    return Font.make(size, name, bold, true)
  }

//////////////////////////////////////////////////////////////////////////
// Metrics
//////////////////////////////////////////////////////////////////////////

  **
  ** Get height of this font which is the pixels is the sum of
  ** ascent, descent, and leading.
  **
  abstract Int height()

  **
  ** Get ascent of this font which is the distance in pixels from
  ** baseline to top of chars, not including any leading area.
  **
  abstract Int ascent()

  **
  ** Get descent of this font which is the distance in pixels from
  ** baseline to bottom of chars, not including any leading area.
  **
  abstract Int descent()

  **
  ** Get leading of this font which is the distance in pixels above
  ** the ascent which may include accents and other marks.
  **
  abstract Int leading()

  **
  ** Get the width of the string in pixels when painted
  ** with this font.
  **
  abstract Int width(Str s)


}