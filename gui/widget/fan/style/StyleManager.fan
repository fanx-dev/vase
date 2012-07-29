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
      Button# : ButtonStyle(),
      ImageView# : ImageStyle(),
      Label# : LabelStyle(),
      TextField# : TextFieldStyle(),
      ToggleButton# : ToggleButtonStyle()
    ]
    defStyle = WidgetStyle()
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