//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

@Js
class StyleManager
{
  Str:Style idMap := [:]
  Str:Style styleClassMap := [:]
  Type:Style typeMap
  private Style defStyle

  new make()
  {
    typeMap =
    [
      Button# : RoundButtonStyle(),
      ImageView# : ImageStyle(),
      Label# : LabelStyle(),
      TextField# : TextFieldStyle(),
      ToggleButton# : ToggleButtonStyle(),
      ScrollBar# : ScrollBarStyle(),
      MessageBox# : MessageBoxStyle(),
      ComboBox# : ButtonStyle(),
      Table# : TableStyle()
    ]
    defStyle = WidgetStyle()

    styleClassMap["menuItem"] = ButtonStyle()
    styleClassMap["radio"] = RadioButtonStyle()
    styleClassMap["treeNodeItem"] = TreeStyle()
    styleClassMap["tableHeader"] = TableHeaderStyle()
  }

  Style find(Widget widget)
  {
    s := idMap.get(widget.id)
    if (s != null) return s

    s = styleClassMap.get(widget.styleClass)
    if (s != null) return s

    s = typeMap.get(widget.typeof)
    if (s != null) return s

    return defStyle
  }
}