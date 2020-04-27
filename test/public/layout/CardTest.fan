

using vaseGui

@Js
class PaneStyleTest : BaseTestWin
{
  CardBox? card

  protected override Widget build() {
    card = CardBox
    {
      it.padding = Insets(50)
      it.margin = Insets(50)
      
      Button
      {
        it.id = "btn1"
        it.text = "btn1"
        layout.offsetY = 50f
        onAction.add { card.selIndex = 1 }
      },
      Button
      {
        it.id = "btn2"
        it.text = "btn2"
        layout.offsetY = 100f
        onAction.add { card.selIndex = 2 }
      },
      Button
      {
        it.id = "btn3"
        it.text = "btn3"
        layout.offsetY = 150f
        onAction.add { card.selIndex = 0 }
      },
    }
    return card
  }

}