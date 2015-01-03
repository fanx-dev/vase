//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using fgfxGraphics
using concurrent

**
** root view
**
@Js
mixin EditText : View
{
  virtual Void willTextChange(Str text) {}
  virtual Void didTextChange(Str text) {}
}

@Js
mixin NativeEditText : NativeView
{
  abstract Str text
  abstract Void setEnabled(Bool e)
  abstract Void setBound(Int x, Int y, Int w, Int h)

  const static Int inputTypeText := 1
  const static Int inputTypeIntNumber := 2
  const static Int inputTypeFloatNumber := 3
  const static Int inputTypePassword := 4
  abstract Void setInputType(Int type)


  abstract Void setSingleLine(Bool single)

  abstract Void setTextSelectable(Bool selectable)
  abstract Void setSelection(Int start, Int stop)

  abstract Void setTextColor(Color color)
  abstract Void setFont(Font font)
  abstract Void setBackgroundColor(Color color)
}

