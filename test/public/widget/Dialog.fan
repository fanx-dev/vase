


using vaseGui

@Js
class DialogTest : BaseTestWin
{
  protected override Widget build() {
    VBox
    {
      Button {
        it.onClick {
          AlertDialog("HI", "OK", "Cancel").show(root)
        }
      },
      Button {
        it.onClick {
          ActionDialog("HI", ["ABC", "1234", "5678"], "Cancel").show(root)
        }
      },
    }
  }
}