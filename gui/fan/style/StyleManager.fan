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
      RadioButton# : RadioButtonStyle(),
      ScrollBar# : ScrollBarStyle(),
      SeekBar# : SeekBarStyle(),
      MessageBox# : MessageBoxStyle(),
      ComboBox# : ComboBoxStyle(),
      ButtonBase# : ButtonBaseStyle(),
      Table# : TableStyle(),
      TreeView# : TreeStyle(),
      TextArea# : TextAreaStyle(),
      MenuItem# : MenuItemStyle(),
      Menu# :  MenuStyle(),
      Switch# : SwitchStyle(),
    ]
    defStyle = WidgetStyle()

    styleClassMap["menuItem"] = MenuItemStyle()
    styleClassMap["tableHeader"] = TableHeaderStyle()
  }

  private Style? findByType(Type type) {
    s := typeMap.get(type)
    if (s != null) {
      return s
    }
    if (type == Obj#) {
      return null
    }

    return findByType(type.base)
  }

  Style find(Widget widget)
  {
    s := idMap.get(widget.id)
    if (s != null) return s

    s = styleClassMap.get(widget.styleClass)
    if (s != null) return s

    s = findByType(widget.typeof)
    if (s != null) return s

    return defStyle
  }
}