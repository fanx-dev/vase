

using vaseGui

@Js
class CardTest : BaseTestWin
{
  CardBox? card
  TabView? tab

  protected override Widget build() {
    r := VBox {
      tab = TabView(["Page1", "Page2", "Page3", "Page4", "Page5"]),
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
    tab.bind(card)
    return r
  }

}