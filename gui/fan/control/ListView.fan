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
class ListView : ScrollPane
{
  @Transient
  private Int rowHeight := 100

  private Bool itemLayoutDirty := true

  @Transient
  ListAdapter? model {
    set { &model = it; init }
  }

  new make(|This|? f := null)
  {
    if (f != null) f(this)
    layout.height = Layout.matchParent
    super.autoScrollContent = false
    this.content = Pane { it.layout.height = Layout.matchParent }
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

  protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1) {
    //r := super.prefContentSize(result)
    return Size(dpToPixel(200), contentMaxHeight.toInt)
  }

  protected Widget getView(Int i) {
    model.getView(i)
  }

  protected override Void onViewportChanged() { itemLayoutDirty = true }

  protected override Void paintChildren(Rect clip, Graphics g) {
    //result := Dimension(-1, -1)
    
    if (itemLayoutDirty) {
      itemLayoutDirty = false
      layoutItem()
    }

    vbar.viewport = viewportHeight
    vbar.max = contentMaxHeight()
    
    super.paintChildren(clip, g)
  }

  protected virtual Void layoutItem() {
    x := paddingTop
    y := paddingLeft
    w := width
    h := height

    Int i := (offsetY / rowHeight).toInt
    Int topOffset := offsetY - (i * rowHeight).toInt
    y -= topOffset

    Pane pane := content
    pane.children.each { it.setParent(null) }
    pane.children.clear

    Int count := 0
    if (i < 0) {
      y += (-i * rowHeight.toInt)
      i = 0
    }
    newHeight := 0
    for (; i< model.size; ++i)
    {
      view := getView(i)
      view.layout.ignored = true
      pane.children.add(view)
      view.setParent(pane)
      ++count

      itemSize := view.bufferedPrefSize(w, h)
      cx := x + view.layout.prefX(this, w, h, itemSize.w)
      view.setLayout(cx, y, itemSize.w, itemSize.h, false)
      y += itemSize.h
      newHeight += itemSize.h

      if (y > h) {
        break
      }
    }
    
    rowHeight = newHeight/count

    model.flush
  }
}

@Js
internal class ListItem {
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

  //private Bool dirty := true

  abstract Int size()

  protected abstract Obj getData(Int i)
  
  protected virtual Int getType(Int i, Obj data) { 1 }

  protected abstract Void bind(Widget w, Obj data)

  protected abstract Widget newView(Int type)

  Void flush() {
    itemPool.flush
  }

  protected virtual Widget getView(Int pos) {
    ListItem? item := itemPool.get(pos)
    if (item != null) {
      //if (dirty) {
      //  bind(item.view, item.data)
      //}
      return item.view
    }

    Obj data = getData(pos)
    type := getType(pos, data)
    
    reuseItem := itemPool.reuse(type)
    if (reuseItem != null) {
      item = reuseItem
    } else {
      item = ListItem()
      item.view = newView(type)
      item.type = type
    }
    item.data = data
    item.pos = pos
    bind(item.view, data)
    itemPool.add(pos, item)
    return item.view
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

  protected override Obj getData(Int i) {
    list[i]
  }

  protected override Void bind(Widget w, Obj data) {
    Label l := w
    l.text = data.toStr
  }

  protected override Widget newView(Int type) {
    //echo("new view")
    return Label{ padding = Insets(8) }
  }
}