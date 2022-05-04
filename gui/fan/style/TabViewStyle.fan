
using vaseGraphics
using vaseWindow

@Js
class TabItemStyle : FlatButtonStyle
{
  new make() {
    fontColor = Color.gray
    //font = Font(35, "Arial", false)
    fontInfo.bold = false
    fontInfo.size = 30
    background = Color(0xe0e0e0)
  }
}

@Js
class TabItemHighlightStyle : FlatButtonStyle
{
  new make() {
    fontColor = color//Color(0x5577CC)
    //font = Font(35, "Arial", true)
    fontInfo.bold = false
    fontInfo.size = 30
    background = Color(0xe0e0e0)
  }
}
