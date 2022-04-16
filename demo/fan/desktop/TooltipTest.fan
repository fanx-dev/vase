using vaseGui
using vaseWindow
using vaseGraphics


@Js
class TooltipTest : BasePage
{
  protected override Widget view() {
    VBox
    {
      padding = Insets(50)
      layout.height = Layout.matchParent

      Button {
        text = "Button";
        tooltip = "hello world"
      },
    }
  }
}