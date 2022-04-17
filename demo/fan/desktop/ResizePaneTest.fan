using vaseGui
using vaseWindow
using vaseGraphics


@Js
class ResizePaneTest : BasePage
{
  protected override Widget view() {
    Pane
    {
      padding = Insets(50)
      layout.height = Layout.matchParent

      ResizePane {
          layout = Layout { width = 300; height = 300 }
          Button {
            layout.height = Layout.matchParent
            text = "Button";
          },
      },
    }
  }
}