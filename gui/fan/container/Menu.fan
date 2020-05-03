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
    layout.height = Layout.wrapContent
    layout.width = Layout.matchParent
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
  internal MenuList subMenuList
  private Bool topLevel := true

  new make()
  {
    this.onAction.add {
      if (subMenuList.childrenSize > 0) {
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
          if (subMenuList.childrenSize > 0) {
            expand(getRootView.topOverlayer)
            //getRootView.modal = true
          }
        }
      }
    }

    subMenuList = MenuList()
    subMenuList.owner = this
    padding = Insets(20)
    this.layout.width = Layout.wrapContent
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

  Void expand(WidgetGroup layer)
  {
    if (subMenuList.parent != null)
    {
      subMenuList.detach
    }
    else
    {
      //reset
      layer.removeAll
      addParentTo(layer)

      layer.add(subMenuList)
      pos := Coord(0f, 0f)
      rc := this.posOnWindow(pos)
      if (parent is Menu)
      {
        subMenuList.layout.offsetX = pixelToDp(pos.x.toInt)
        subMenuList.layout.offsetY = pixelToDp(pos.y.toInt + this.height)
      }
      else
      {
        subMenuList.layout.offsetX = pixelToDp(pos.x.toInt + this.width)
        subMenuList.layout.offsetY = pixelToDp(pos.y.toInt)
      }
    }

    layer.relayout
  }

  @Operator virtual This add(MenuItem item)
  {
    subMenuList.add(item)
    //item.layout.widthType = SizeType.fixed
    item.layout.width = 500f
    item.padding = Insets(1)
    item.topLevel = false
    return this
  }
}

