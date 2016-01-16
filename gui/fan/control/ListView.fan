//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-08-12  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using fanvasMath

@Js
class ListView : ScrollBase
{
  Float rowHeight := 120f

  @Transient
  ListAdapter? model {
    set { &model = it; init }
  }

  new make(|This|? f := null)
  {
    if (f != null) f(this)
  }

  private Void init() {
  }

  protected override Dimension prefContentSize(Dimension result) {
    result = super.prefContentSize(result)
    result.h = model.size * dpToPixel(rowHeight)
    return result
  }

  protected override Int contentMaxHeight(Dimension result) {
    t := model.size * dpToPixel(rowHeight)
    return t
  }

  Widget getView(Int i) {
    item := model.getItem(i)
    return item.view
  }

  protected override Void paintChildren(Graphics g) {
    x := paddingTop
    y := paddingLeft
    w := width
    h := height

    result := Dimension(-1, -1)
    Int i := offsetY
    for (; i< model.size; ++i)
    {
      view := getView(i)
      add(view)

      itemH := view.bufferedPrefSize(result).h
      view.layout(x, y, w, itemH, result, false)
      y += itemH

      if (view.visible)
      {
        g.push
        //g.clip(it.bounds)
        g.transform(Transform2D.make.translate(view.x.toFloat, view.y.toFloat))
        view.paint(g)
        g.pop
      }

      view.detach

      if (y > h) {
        break
      }
    }
    model.flush

    super.paintChildren(g)
  }

  override Void layoutChildren(Dimension result, Bool force) {
    super.layoutChildren(result, force)
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
    l.requestPaint
  }

  protected override Widget newView(Int type) {
    //echo("new view")
    return Label{}
  }
}