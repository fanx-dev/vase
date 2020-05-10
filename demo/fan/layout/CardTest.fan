// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-10 yangjiandong Creation
//


using vaseGui

@Js
class CardTest : BasePage
{
  CardPane? card
  TabView? tab
  CardIndicator? indicator

  protected override Widget view() {
    r := VBox {
      margin = Insets(50)
      layout.height = Layout.matchParent
      tab = TabView(["Page1", "Page2", "Page3", "Page4", "Page5"]),
      card = CardPane
      {
        padding = Insets(50)
        layout.height = Layout.matchParent
        Label
        {
          text = "page1"
          style = "h1"
          layout.vAlign = Align.center
          layout.hAlign = Align.center
          layout.width = Layout.wrapContent
        },
        Label
        {
          text = "page2"
          style = "h1"
          layout.vAlign = Align.center
          layout.hAlign = Align.center
          layout.width = Layout.wrapContent
        },
        Label
        {
          text = "page3"
          style = "h1"
          layout.vAlign = Align.center
          layout.hAlign = Align.center
          layout.width = Layout.wrapContent
        },
        Label
        {
          text = "page4"
          style = "h1"
          layout.vAlign = Align.center
          layout.hAlign = Align.center
          layout.width = Layout.wrapContent
        },
        Label
        {
          text = "page5"
          style = "h1"
          layout.vAlign = Align.center
          layout.hAlign = Align.center
          layout.width = Layout.wrapContent
        },
      },
      indicator = CardIndicator {},
    }
    tab.bind(card)
    indicator.cardBox = card
    return r
  }

}