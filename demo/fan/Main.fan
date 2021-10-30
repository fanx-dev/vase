// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-9 yangjiandong Creation
//

using vaseGui
using vaseWindow

abstract class BasePage {
    Frame? frame
    
    protected abstract Widget view()
    protected virtual Void init(Frame frame) {}
    
    Void run() {
        frame = Frame {
            VBox() {
                layout.height = Layout.matchParent
                padding = Insets(8)
                Button {
                  text = "<"
                  style = "flatButton"
                  rippleEnable = false
                  textAlign = Align.begin
                  onClick { frame.pop }
                },
                view,
            },
        }
        init(frame)
        frame.show()
    }
    
    Void main() { run }
}

**
** Main
**
@Js
class Main
{
  Frame? mainView
  BasePage?[] pages
  
  new make() {
    pages = [null,
      ButtonTest(), StyleTest(), ImageViewTest(), ListViewTest(), BubbleViewTest(), ComboBoxTest(), DialogTest(), null,
      SpinnerTest(), SliderBarTest(), ProgressViewTest(), TextViewTest(), null,
      CardTest(), EdgeTest(), HBoxTest(), VBoxTest(), PaneTest(), FlowTest(), null,
      MenuTest(), TableTest(), TreeTest(), null,
      EditTextTest(), FilePickerTest(), AudioTest(), null,
    ]
    init
  }
  
  private Void init() {
    mainView = Frame {
      ScrollPane {
        VBox {
          padding = Insets(40)
          spacing = 15
          Label {
            text = "Vase UI"
            style = "h1"
          },;
          
          v := it
          pages.each |p| {
            if (p == null) {
              v.add(RectView { layout.height = 3 })
              lret
            }
            b := Button {
                style = "flatButton"
                textAlign = Align.begin
                text = p.typeof.name.replace("Test", "")
                onClick { p.run }
            }
            v.add(b)
          }
        },
      },
    }
  }

  Void show() { mainView.show }
  
  static Void main() {
    Main().show
  }
}
