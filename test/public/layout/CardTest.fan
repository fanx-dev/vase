

using vaseGui

@Js
class PaneStyleTest : BaseTestWin
{
  CardBox? card

  protected override Widget build() {
    VBox {
      TabView(["Page1", "Page2", "Page3", "Page4", "Page5"]){
        it.onAction = |i|{ card.selIndex = i }
      },
      card = CardBox
      {
        it.padding = Insets(50)
        it.margin = Insets(50)
        
        Button
        {
          it.text = "btn1"
          layout.offsetY = 50f
        },
        Button
        {
          it.text = "btn2"
          layout.offsetY = 100f
        },
        Button
        {
          it.text = "btn3"
          layout.offsetY = 150f
        },
        Button
        {
          it.text = "btn4"
          layout.offsetY = 200f
        },
        Button
        {
          it.text = "btn5"
          layout.offsetY = 250f
        },
      },
    }
  }

}