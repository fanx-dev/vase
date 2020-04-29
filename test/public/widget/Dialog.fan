


using vaseGui

@Js
class DialogTest : BaseTestWin
{
  protected override Widget build() {
    VBox
    {
      Button {
        it.onClick {
          AlertDialog("HI").show(root)
        }
      },
      Button {
        it.onClick {
          AlertDialog("HI", "OK", "Cancel").show(root)
        }
      },
    }
  }
}