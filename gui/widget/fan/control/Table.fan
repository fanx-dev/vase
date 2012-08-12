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
class Table : WidgetGroup
{
  ScrollBar hbar
  ScrollBar vbar
  TableModel model

  Int rowHeight := 20
  Int colWidth := 60
  Int headerHeight := 20
  Int[] colWidthBuf

  WidgetGroup? header
  Int offsetX := 0
  Int offsetY := 0

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
    header.layout = HBox()
    this.add(header)

    //scroll bar
    hbar = ScrollBar()
    hbar.orientationV = false
    vbar = ScrollBar()
    vbar.orientationV = true

    hbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#startPos)
      {
        offsetX = ((Int)e.newValue)
        header.pos = Point(-offsetX, header.pos.y)
        this.repaint
      }
    }
    vbar.onStateChanged.add |StateChangedEvent e|
    {
      if (e.field == ScrollBar#startPos)
      {
        offsetY = ((Int)e.newValue)
        this.repaint
      }
    }

    this.add(hbar)
    this.add(vbar)

    size = Size(200, 200)
  }

  private Int contentWidth()
  {
    Int w := 0
    model.numCols.times |c|
    {
      w += model.prefWidth(c) ?: colWidth
    }
    return w
  }

  private Int contentHeight()
  {
    model.numRows * rowHeight
  }

  override This relayout()
  {
    header.size = header.prefSize(size)
    header.relayout

    hbar.size = Size(size.w-10, 10)
    hbar.pos = Point(0, size.h-10)
    hbar.max = contentWidth
    if (hbar.max <= hbar.size.w)
    {
      hbar.enabled = false
      hbar.visible = false
    }

    vbar.size = Size(10, size.h-10)
    vbar.pos = Point(size.w-10, 0)
    vbar.max = contentHeight
    vbar.viewPort = this.size.h - headerHeight - 10
    if (vbar.max <= vbar.size.h)
    {
      vbar.enabled = false
      vbar.visible = false
    }

    this.remove(hbar)
    this.remove(vbar)
    this.add(hbar)
    this.add(vbar)
    return this
  }

  override Void touch(MotionEvent e)
  {
    super.touch(e)
    if (!e.consumed)
    {
      p := mapToRelative(Point(e.x, e.y))
      if (!this.bounds.contains(p.x, p.y)) return

      if (e.id == MotionEvent.other && e.delta != null)
      {
        vbar.startPos += e.delta * 10
      }
    }
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