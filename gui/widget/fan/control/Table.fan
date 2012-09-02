//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

@Js
class Table : Scroller
{
  TableModel model

  Int rowHeight := 20
  Int colWidth := 60
  Int headerHeight := 20
  internal Int[] colWidthBuf

  internal WidgetGroup? header

  new make(TableModel model)
  {
    this.model = model
    //header
    header = WidgetGroup()
    colWidthBuf = Int[,]
    model.numCols.times |c|
    {
      btn := Button { it.text = model.header(c) }
      btn.styleClass = "tableHeader"
      w := model.prefWidth(c) ?: colWidth
      colWidthBuf.add(w)
      btn.size = Size(w, headerHeight)
      header.add(btn)
    }
    header.layout = BoxLayout { orientationV = false }
    this.add(header)
  }

  override Int offsetX
  {
    set { header.pos = Point(-it, header.pos.y); super.offsetX = it }
  }

  protected override Int contentWidth()
  {
    Int w := 0
    model.numCols.times |c|
    {
      w += model.prefWidth(c) ?: colWidth
    }
    return w
  }

  protected override Int contentHeight()
  {
    model.numRows * rowHeight
  }

  protected override Int viewportHeight() { this.size.h - headerHeight - barSize }
}

**************************************************************************
** TableModel
**************************************************************************

**
** TableModel models the data of a table widget.
**
@Js
class TableModel
{

  **
  ** Get number of rows in table.
  **
  virtual Int numRows() { 0 }

  **
  ** Get number of columns in table.  Default returns 1.
  **
  virtual Int numCols() { 1 }

  **
  ** Get the header text for specified column.
  **
  virtual Str header(Int col) { "Header $col" }

  **
  ** Return the preferred width in pixels for this column.
  ** Return null (the default) to use the Tables default
  ** width.
  **
  virtual Int? prefWidth(Int col) { null }

  **
  ** Get the text to display for specified cell.
  **
  virtual Str text(Int col, Int row) { "$col:$row" }

  **
  ** Get the image to display for specified cell or null.
  **
  virtual Image? image(Int col, Int row) { null }

  **
  ** Compare two cells when sorting the given col.  Return -1,
  ** 0, or 1 according to the same semanatics as `sys::Obj.compare`.
  ** Default behavior sorts `text` using `sys::Str.localeCompare`.
  ** See `fwt::Table.sort`.
  **
  virtual Int sortCompare(Int col, Int row1, Int row2)
  {
    text(col, row1).localeCompare(text(col, row2))
  }
}