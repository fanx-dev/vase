//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fgfxGraphics
using fgfxWtk
using fgfxWidget
using fgfxFwt

**
** TableTest
**
@Js
class TableTest
{
  Bool initEnv() {
    if (Env.cur.runtime != "java") {
      ToolkitEnv.init
      return true
    }
    if (Env.cur.args.size > 0) {
      if (Env.cur.args.first == "AWT") {
        ToolkitEnv.init
        return true
      }
      else if (Env.cur.args.first == "SWT") {
        FwtToolkitEnv.init
        return true
      }
    }
    echo("AWT or SWT ?")
    return false
  }

  Void main()
  {
    if (!initEnv) return

    view := RootView
    {
      Table(MyTableModel()),
    }

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

