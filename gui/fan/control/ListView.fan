//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using vaseMath

@Js
class ListView : ScrollBase
{
  @Transient
  private Float rowHeight := 100f

  @Transient
  private Widget[] tempChildren := [,]

  private Bool itemLayoutDirty := true

  @Transient
  ListAdapter? model {
    set { &model = it; init }
  }

  new make(|This|? f := null)
  {
    if (f != null) f(this)
    layoutParam.height = LayoutParam.matchParent
  }

  private Void init() {
  }

  protected override Float viewportHeight() {
    contentHeight.toFloat
  }

  protected override Float contentMaxHeight() {
    t := model.size * rowHeight
    return t.toFloat
  }

  protected override Dimension prefContentSize() {
    //r := super.prefContentSize(result)
    return Dimension(dpToPixel(200f), dpToPixel(400f))
  }

  protected Widget getView(Int i) {
    item := model.getItem(i)
    return item.view
  }

  protected override Void onViewportChanged() { itemLayoutDirty = true }

  protected override Void paintChildren(Graphics g) {
    //result := Dimension(-1, -1)
    
    if (itemLayoutDirty) {
      itemLayoutDirty = false
      layoutItem()
    }

    vbar.viewport = viewportHeight
    vbar.max = contentMaxHeight()

    moveToTop(vbar)
    moveToTop(hbar)
    super.paintChildren(g)
  }

  protected virtual Void layoutItem() {
    x := paddingTop
    y := paddingLeft
    w := width
    h := height

    Int i := (offsetY / rowHeight).toInt
    Int topOffset := offsetY - (i * rowHeight).toInt
    y -= topOffset

    tempChildren.each { it.detach(false) }
    tempChildren.clear

    Int count := 0
    if (i < 0) {
      y += (-i * rowHeight.toInt)
      i = 0
    }
    for (; i< model.size; ++i)
    {
      view := getView(i)
      tempChildren.add(view)
      view.layoutParam.ignore = true
      doAdd(view)
      ++count

      itemH := view.bufferedPrefSize().h
      view.layout(x, y, w, itemH, false)
      y += itemH
      rowHeight = itemH.toFloat

      if (y > h) {
        break
      }
    }

    model.flush
  }
}

@Js
class ListItem {
  Obj? data
  Widget? view
  Int type := 0
  Int pos := -1
  Int mode := -1
}

@Js
internal class ListItemPool {
  private [Int : ListItem[]] freeList := [:]
  private [Int:ListItem] activesMap := [:]
  private Int mode := 0

  ListItem? get(Int pos) {
    ListItem? item := activesMap[pos]
    if (item != null) {
      item.mode = mode
      return item
    }
    return item
  }

  ListItem? reuse(Int type) {
    if (freeList.size > 0) {
      ListItem[]? list := freeList[type]
      if (list != null) {
        item := list.pop
        return item
      }
    }
    return null
  }

  Void add(Int pos, ListItem item) {
    activesMap[pos] = item
    item.mode = mode
  }

  Void flush() {
    old := activesMap.findAll { it.mode != this.mode }
    old.each {
      list := freeList.getOrAdd(it.type){ ListItem[,] }
      list.add(it)
      activesMap.remove(it.pos)
    }
    mode = mode == 0 ? 1 : 0
  }
}

@Js
abstract class ListAdapter
{
  private ListItemPool itemPool := ListItemPool()

  private Bool dirty := true

  abstract Int size()

  protected abstract Void getData(Int i, ListItem out)

  protected abstract Void bind(Widget w, Obj data)

  protected abstract Widget newView(Int type)

  Void flush() {
    itemPool.flush
  }

  virtual ListItem getItem(Int pos) {
    ListItem? item := itemPool.get(pos)
    if (item != null) {
      if (dirty) {
        bind(item.view, item.data)
      }
      return item
    }

    item = ListItem()
    item.pos = pos
    getData(pos, item)

    reuseItem := itemPool.reuse(item.type)
    if (reuseItem != null) {
      item.view = reuseItem.view
    } else {
      item.view = newView(item.type)
    }

    bind(item.view, item.data)
    itemPool.add(pos, item)
    return item
  }
}

@Js
class SimpleListAdapter : ListAdapter
{
  protected Obj[] list

  new make(Obj[] list) {
    this.list = list
  }

  override Int size() { list.size }

  protected override Void getData(Int i, ListItem out) {
    out.data = list[i]
    out.type = 0
  }

  protected override Void bind(Widget w, Obj data) {
    Label l := w
    l.text = data.toStr
  }

  protected override Widget newView(Int type) {
    //echo("new view")
    return Label{}
  }
}