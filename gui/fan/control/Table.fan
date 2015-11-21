//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

@Js
class Table : ScrollBase
{
  TableModel model

  Int colWidth := dpToPixel(360f)
  Int headerHeight { private set }
  internal Int[] colWidthCache

  internal WidgetGroup? header
  Int rowHeight
  Font font {
    set { rowHeight = it.height; headerHeight = rowHeight; &font = it; }
  }

  new make(TableModel model)
  {
    this.model = model
    font = Font(dpToPixel(41f))
    //header
    header = LinearLayout { vertical = false }
    colWidthCache = Int[,]
    model.numCols.times |c|
    {
      btn := ButtonBase { it.text = model.header(c) }
      btn.styleClass = "tableHeader"
      w := model.prefWidth(c) ?: colWidth
      colWidthCache.add(w)
      btn.layoutParam.width = w
      btn.layoutParam.height = headerHeight
      header.add(btn)
    }
    this.add(header)
  }

  override Int offsetX
  {
    set { header.x = -it; super.offsetX = it }
  }

  protected override Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result) {
    Int w := 0
    model.numCols.times |c|
    {
      w += model.prefWidth(c) ?: colWidth
    }
    Int h := model.numRows * rowHeight + headerHeight

    return result.set(w, h)
  }

  protected override Int contentMaxHeight(Dimension result) {
    t := model.numRows * rowHeight
    //echo("contentMaxHeight$t")
    return t
  }
  protected override Int viewportHeight() {
    t := super.viewportHeight - headerHeight
    //echo("viewportHeight$t, headerHeight$headerHeight, super.viewportHeight$super.viewportHeight")
    return t
  }
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