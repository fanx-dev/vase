//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** Menu contains MenuItems.
**
@Js
class Menu : WidgetGroup
{
  new make()
  {
    layout = BoxLayout { orientationV = false }
  }

  Void close()
  {
    rootView.topLayer.removeAll
    rootView.repaint
  }
}

@Js
class MenuList : WidgetGroup
{
  MenuItem? owner

  new make()
  {
    layout = BoxLayout { orientationV = true }
  }
}

@Js
class MenuItem : Button
{
  MenuList list

  new make()
  {
    this.onAction.add
    {
      if (list.childrenSize > 0)
      {
        expand(rootView.topLayer)
      }
      else
      {
        rootMenu?.close
      }
    }
    list = MenuList()
    list.owner = this
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
      group.removeAll
      addParentTo(group)

      group.add(list)
      pos := this.posOnWindow
      if (parent is Menu)
      {
        list.pos = Point(pos.x, pos.y + this.size.h)
      }
      else
      {
        list.pos = Point(pos.x + this.size.w, pos.y)
      }
    }

    group.relayout
    group.repaint
  }

  This addItem(MenuItem item)
  {
    list.add(item)
    return this
  }
}

