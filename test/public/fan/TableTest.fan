//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using fanvasGui

@Js
class TableTest : BaseTestWin
{
  protected override Widget build() {
    Table { model = MyTableModel() }
  }

  override Void main() { super.main }
}

@Js
class MyTableModel : TableModel
{
  Str[] vals := Str[,]

  Str headerPrefix := "Col-"

  new make() {
    20.times { vals.add("row $it") }
  }

  override Str header(Int col) { headerPrefix + col }
  override Str text(Int col, Int row)
  {
    if (col == 0) return vals[row]
    return "$row : $col"
  }
  override Int numRows() { vals.size }
  override Int numCols := 5
}