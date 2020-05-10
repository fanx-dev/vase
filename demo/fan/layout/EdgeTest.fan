
using vaseGui


class EdgeTest : BasePage {
  protected override Widget view() {
    EdgeBox
    {
      top = Button {  text = "top" }
      left = Button { text = "left" }
      right = Button { text = "right" }
      bottom = Button { text = "bottom" }
      center = Button { text = "center" }
    }
  }
}