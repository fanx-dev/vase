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
  @Transient
  TableModel model := TableModel() {
    set { &model = it; init }
  }

  Float colWidth := 360 * 2f
  Float rowHeight := 120f

  @Transient
  internal Int[]? colWidthCache

  @Transient
  internal WidgetGroup header := LinearLayout {
    it.vertical = false
    it.layoutParam.widthType = SizeType.wrapContent
  }

  new make(|This|? f := null)
  {
    if (f != null) f(this)
    this.add(header)
  }

  private Void init() {
    colWidthCache = Int[,]
    header.removeAll
    colWidth := dpToPixel(colWidth)
    model.numCols.times |c|
    {
      btn := ButtonBase { it.text = model.header(c) }
      btn.styleClass = "tableHeader"
      w := model.prefWidth(c) ?: colWidth
      colWidthCache.add(w)
      btn.layoutParam.widthType = SizeType.fixed
      btn.layoutParam.widthVal = pixelToDp(w)
      btn.layoutParam.heightType = SizeType.fixed
      btn.layoutParam.heightVal = rowHeight
      header.add(btn)
    }
  }

  override Int offsetX
  {
    set { header.x = -it; super.offsetX = it }
  }

  protected override Dimension prefContentSize(Dimension result) {
    Int w := 0
    Int colWidth := dpToPixel(colWidth)
    model.numCols.times |c|
    {
      w += model.prefWidth(c) ?: colWidth
    }
    Int h := model.numRows * dpToPixel(rowHeight) + dpToPixel(rowHeight)

    return result.set(w, h)
  }

  protected override Int contentMaxHeight(Dimension result) {
    t := model.numRows * dpToPixel(rowHeight)
    //echo("contentMaxHeight$t")
    return t
  }
  protected override Int viewportHeight() {
    t := super.viewportHeight - dpToPixel(rowHeight)
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