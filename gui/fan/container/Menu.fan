//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** Menu contains MenuItems.
**
@Js
class Menu : HBox
{
  new make()
  {
    //vertical = false
    layoutParam.height = LayoutParam.wrapContent
    layoutParam.width = LayoutParam.matchParent
  }

  Void close()
  {
    getRootView.topOverlayer.removeAll
    getRootView.repaint
  }
}

@Js
internal class MenuList : VBox
{
  @Transient
  MenuItem? owner

  new make()
  {
    spacing = 0f//(dpToPixel(10f))
    margin = Insets(3)
  }
}

@Js
class MenuItem : ButtonBase
{
  internal MenuList list
  private Bool topLevel := true

  new make()
  {
    this.onAction.add {
      if (list.childrenSize > 0) {
        expand(getRootView.topOverlayer)
        //getRootView.modal = true
      }
      else {
        //getRootView.modal = false
        rootMenu?.close
      }
    }

    this.onStateChanged.add |StateChangedEvent e| {
      if (!topLevel && e.field == ButtonBase#state) {
        newVal := ((Int)e.newValue)
        if (newVal == ButtonBase.mouseOver) {
          if (list.childrenSize > 0) {
            expand(getRootView.topOverlayer)
            //getRootView.modal = true
          }
        }
      }
    }

    list = MenuList()
    list.owner = this
    padding = Insets(20)
    this.layoutParam.width = LayoutParam.wrapContent
  }

  private Menu? rootMenu()
  {
    MenuList? list := this.parent as MenuList
    while (list != null)
    {
      if (list.owner.parent is Menu)
      {
        return list.owner.parent as Menu
      }
      list = list.owner.parent as MenuList
    }
    return null
  }

  private Void addParentTo(WidgetGroup group)
  {
    MenuList? list := this.parent as MenuList
    while (list != null)
    {
      group.add(list)
      MenuItem owner := list.owner
      list = owner.parent as MenuList
    }
  }

  Void expand(WidgetGroup group)
  {
    if (list.parent != null)
    {
      list.detach
    }
    else
    {
      //reset
      group.removeAll
      addParentTo(group)

      group.add(list)
      pos := Coord(0, 0)
      rc := this.posOnWindow(pos)
      if (parent is Menu)
      {
        list.layoutParam.offsetX = pixelToDp(pos.x)
        list.layoutParam.offsetY = pixelToDp(pos.y + this.height)
      }
      else
      {
        list.layoutParam.offsetX = pixelToDp(pos.x + this.width)
        list.layoutParam.offsetY = pixelToDp(pos.y)
      }
    }

    group.relayout
  }

  @Operator virtual This add(MenuItem item)
  {
    list.add(item)
    //item.layoutParam.widthType = SizeType.fixed
    item.layoutParam.width = 500f
    item.padding = Insets(1)
    item.topLevel = false
    return this
  }
}

