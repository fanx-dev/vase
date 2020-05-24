


using vaseGui

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
        onClick {
          PromptDialog("Input", "OK", "Cancel").show(it)
        }
      }
    }
  }
}