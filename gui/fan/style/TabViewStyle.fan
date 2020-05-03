// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020Äê5ÔÂ3ÈÕ Administrator Creation
//
using vaseGraphics
using vaseWindow

@Js
class TabItemStyle : LabelStyle
{
  new make() {
    fontColor = Color.gray
    font = Font(35, "Arial", false)
  }
}

@Js
class TabItemHighlightStyle : LabelStyle
{
  new make() {
    fontColor = Color(0x5577CC)
    font = Font(35, "Arial", true)
  }
}
