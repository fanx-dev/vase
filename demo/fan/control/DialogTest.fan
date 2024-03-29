


using vaseGui
using vaseWindow

@Js
class DialogTest : BasePage
{
  protected override Widget view() {
    VBox
    {
      Button {
        text = "Alert"
        onClick {
          AlertDialog("HI", "OK", "Cancel").show(it)
        }
      },
      Button {
        text = "Alert2"
        onClick {
          a := AlertDialog("HI", null)
          a.show(it)
          Toolkit.cur.callLater(3000) {
            echo("close")
            a.close()
          }
        }
      },
      Button {
        text = "Action"
        onClick {
          ActionDialog("HI", ["ABC", "1234", "5678"], "Cancel").show(it)
        }
      },
      Button {
        text = "Time"
        onClick {
          TimeDialog("OK", "Cancel").show(it)
        }
      },
      Button {
        text = "Date"
        onClick {
          DateDialog("OK", "Cancel").show(it)
        }
      },
      Button {
        text = "Prompt"
        onClick |w|{
          PromptDialog("Input", "OK", "Cancel").show(w).onAction = |msg| {
            Toast("$msg").show(w)
          }
        }
      }
    }
  }
}