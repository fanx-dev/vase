//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fgfx2d
using fgfxWtk
using fgfxWidget

**
** TableTest
**
@Js
class TableTest
{
  Void main()
  {
    ToolkitEnv.init

    view := RootView
    {
      Table(MyTableModel()),
    }

    view.size = Size(600, 600)
    view.show
  }
}

@Js
class MyTableModel : TableModel
{
  Str[] vals := ["apple", "orange", "red", "pink", "fantom",
    "java", "javascript", "python", "ruby", "purple",
    "black", "star wars", "fight club", "casablanca", "inception",
    "aug", "sep", "oct", "nov", "dec"]

  Str headerPrefix := "Col-"

  override Str header(Int col) { headerPrefix + col }
  override Str text(Int col, Int row)
  {
    if (col == 0) return vals[row]
    return "$row : $col"
  }
  override Int numRows := vals.size
  override Int numCols := 5
}

