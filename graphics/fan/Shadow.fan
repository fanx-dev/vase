//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-02  Jed Young  Creation
//


**
** High Performance Point Array
**
@Js
@Serializable { simple = true }
const class Shadow
{
  const Int blur
  const Int offsetX
  const Int offsetY
  const Color color

  **
  ** Construct with it-block
  **
  new make(|This| f) { f(this) }

  static Shadow? fromStr(Str s, Bool checked := true)
  {
    try
    {
      toks := s.split
      return Shadow {
        blur=toks[0].toInt
        offsetX=toks[1].toInt
        offsetY=toks[2].toInt
        color=Color(toks[3].toStr)
      }
    }
    catch {}
    if (checked) throw ParseErr("Invalid Shadow: $s")
    return null
  }

  override Str toStr() {
    "$blur,$offsetX,$offsetY,$color"
  }

  **
  ** Hash the fields.
  **
  override Int hash()
  {
    h := blur.xor(offsetX.shiftl(16))
      .xor(offsetY.shiftl(20))
      .xor(color.hash.shiftl(31))
    return h
  }

  **
  ** Equality is based on Pen's fields.
  **
  override Bool equals(Obj? obj)
  {
    that := obj as Shadow
    if (that == null) return false
    return this.blur == that.blur &&
           this.offsetX   == that.offsetX   &&
           this.offsetY  == that.offsetY  &&
           this.color  == that.color
  }
}