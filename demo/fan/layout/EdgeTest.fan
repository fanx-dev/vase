
using vaseGui


class EdgeTest : BasePage {
  protected override Widget view() {
    EdgeBox
    {
      top = Button {  text = "top"; padding = Insets(8) }
      left = Button { text = "left"; padding = Insets(8) }
      right = Button { text = "right"; padding = Insets(8) }
      bottom = Button { text = "bottom"; padding = Insets(8) }
      center = Button { text = "center"; padding = Insets(8) }
    }
  }
}