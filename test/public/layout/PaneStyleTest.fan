

using vaseGui

@Js
class PaneStyleTest : BaseTestWin
{
  protected override Widget build() {
    VBox
    {
      it.padding = Insets(50)
      it.margin = Insets(50)
      styleClass = "pane"
      Button
      {
        it.id = "btn1"
        it.text = "btn1"
      },
    }
  }
}