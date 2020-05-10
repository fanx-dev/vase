using vaseGui

@Js
class TextViewTest : BasePage
{
  protected override Widget view() {
    VBox {
      padding = Insets(50)
      Label {
        style = "h1"
        text = "H1"
      },
      Label {
        style = "h2"
        text = "H2"
      },
      Label {
        style = "h3"
        text = "H3"
      },
      Label {
        style = "h4"
        text = "H4"
      },
      TextView {
        autoWrap = false
        text = "Hello1\nHello2"
      },
      
      TextView {
        s := it
        100.times { s.text += ",$it" }
      },
    }
  }
}