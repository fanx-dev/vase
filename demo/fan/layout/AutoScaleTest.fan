using vaseGui

@Js
class AutoScaleTest : BasePage
{
  protected override Widget view() {
    Pane {
      Button {
        layout = Layout {
          offsetX = 340
          offsetY = 340
          height = 400
          width = 400
        }
      },
    }
  }

  protected override Void init(Frame frame) {
    frame.autoScale = true
  }
}
