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
  Pane layer
  
  new make()
  {
    //vertical = false
    layout.height = Layout.wrapContent
    layout.width = Layout.matchParent
    layer = Pane { it.layout.height = Layout.matchParent }
  }

  Void close()
  {
    layer.removeAll
    layer.detach
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
class MenuItem : Button
{
  internal MenuList subMenuList
  private Bool topLevel := true
  
  new make()
  {
    this.onAction.add {
      if (subMenuList.childrenSize > 0) {
        layer := rootMenu.layer
        if (layer.parent == null) {
            getRootView.topOverlayer.add(layer)
        }
        expand(layer)
        //getRootView.modal = true
      }
      else {
        //getRootView.modal = false
        rootMenu?.close
      }
    }

    this.onStateChanged.add |StateChangedEvent e| {
      root := rootMenu
      if (root == null) return
      layer := root.layer
      if (layer.parent != null && e.field == Button#state) {
        newVal := ((Int)e.newValue)
        if (newVal == Button.mouseOver) {
          if (subMenuList.childrenSize > 0) {
            if (layer.parent == null) {
                getRootView.topOverlayer.add(layer)
            }
            expand(layer)
            //getRootView.modal = true
          }
        }
      }
    }

    subMenuList = MenuList()
    subMenuList.owner = this
    padding = Insets(15)
    textAlign = Align.begin
    style = "menuItem"
    this.layout.width = Layout.wrapContent
  }

  private Menu? rootMenu()
  {
    if (this.parent is Menu) return (Menu)this.parent
     
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

  private Void addParentTo(WidgetGroup layer)
  {
    MenuList? list := this.parent as MenuList
    while (list != null)
    {
      layer.add(list)
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
    item.padding = Insets(5)
    item.topLevel = false
    return this
  }
}

