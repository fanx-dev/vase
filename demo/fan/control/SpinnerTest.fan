

using vaseWindow
using vaseGui

@Js
class SpinnerTest : BasePage
{
  
  protected override Widget view() {
    Label? lab
    Spinner? spinner
    
    p := Pane {
      margin = Insets(100)
      spinner = Spinner {
        s := it
        100.times { s.items.add("item$it") }
        selIndex = 5
        layout.hAlign = Align.center
        layout.vAlign = Align.center
      },
      lab = Label { text = "Hello" },
    }

    spinner.onStateChanged.add |StateChangedEvent e|{
        if (e.field == Spinner#selIndex) {
            lab.text = e.newValue.toStr
            lab.repaint
        }
    }
    
    return p
  }
}