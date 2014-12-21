//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk

**
** Menu contains MenuItems.
**
@Js
class Menu : LinearLayout
{
  new make()
  {
    vertical = false
    layoutParam.height = LayoutParam.wrapContent
    layoutParam.width = LayoutParam.matchParent
  }

  Void close()
  {
    getRootView.topOverlayer.removeAll
    getRootView.requestPaint
  }
}

@Js
internal class MenuList : LinearLayout
{
  MenuItem? owner

  new make()
  {
    //spacing = (dpToPixel(10))
    layoutParam.margin = Insets(dpToPixel(10))
  }
}

@Js
class MenuItem : ButtonBase
{
  internal MenuList list

  new make()
  {
    this.onAction.add
    {
      if (list.childrenSize > 0)
      {
        expand(getRootView.topOverlayer)
        getRootView.modal = true
      }
      else
      {
        getRootView.modal = false
        rootMenu?.close
      }
    }
    list = MenuList()
    list.owner = this
    padding = Insets(dpToPixel(20))
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
        list.layoutParam.posX = pos.x
        list.layoutParam.posY = pos.y + this.height
      }
      else
      {
        list.layoutParam.posX = pos.x + this.width
        list.layoutParam.posY = pos.y
      }
    }

    group.layout
  }

  @Operator virtual This add(MenuItem item)
  {
    list.add(item)
    item.layoutParam.width = font.height * 10
    item.padding = Insets.defVal
    return this
  }
}

