//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class Table : ScrollPane
{
  @Transient
  TableModel model := TableModel() {
    set { &model = it; init }
  }

  Int colWidth := 360
  Int rowHeight := 60

  @Transient
  internal Int[]? colWidthCache

  @Transient
  internal WidgetGroup header := HBox {
    //it.vertical = false
    it.spacing = 0
    //it.layout.width = Layout.wrapContent
  }

  new make(|This|? f := null)
  {
    if (f != null) f(this)
    layout.height = Layout.matchParent
    super.autoScrollContent = false
    this.content = header
  }

  private Void init() {
    colWidthCache = Int[,]
    header.removeAll
    colWidth := dpToPixel(colWidth)
    model.numCols.times |c|
    {
      btn := Button {
        it.text = model.header(c)
        it.style = "tableHeader"
        it.padding = Insets.defVal
      }
      w := model.prefWidth(c) ?: colWidth
      colWidthCache.add(w)
      //btn.layout.widthType = SizeType.fixed
      btn.layout.width = pixelToDp(w)
      //btn.layout.heightType = SizeType.fixed
      btn.layout.height = rowHeight
      header.add(btn)
    }
  }

  override Int offsetX
  {
    set { header.x = -it; super.offsetX = it }
  }

  protected override Dimension prefContentSize() {
    Int w := 0
    Int colWidth := dpToPixel(colWidth)
    model.numCols.times |c|
    {
      w += model.prefWidth(c) ?: colWidth
    }
    Int h := model.numRows * dpToPixel(rowHeight) + dpToPixel(rowHeight)

    return Dimension(w, h)
  }

  protected override Float contentMaxHeight() {
    t := model.numRows * dpToPixel(rowHeight)
    //echo("contentMaxHeight$t")
    return t.toFloat
  }
  protected override Float viewportHeight() {
    t := super.viewportHeight - dpToPixel(rowHeight)
    //echo("viewportHeight$t, headerHeight$headerHeight, super.viewportHeight$super.viewportHeight")
    return t.toFloat
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
    text(col, row1).compare(text(col, row2))
  }
}