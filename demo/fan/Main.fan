// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-9 yangjiandong Creation
//

using vaseGui


abstract class BasePage {
    Frame? frame
    
    protected abstract Widget view()
    
    Void run() {
        frame = Frame {
            VBox() {
                layout.height = Layout.matchParent
                Button {
                  text = "< back"
                  style = "flatButton"
                  textAlign = Align.begin
                  onClick { frame.pop }
                },
                view,
            },
        }
        frame.show
    }
}

**
** Main
**
class Main
{

  BasePage?[] frames
  
  new make() {
    frames = [null,
      ButtonTest(), ImageViewTest(), DialogTest(), ListViewTest(), null,
      SpinnerTest(), SeekBarTest(), ProgressViewTest(), TextViewTest(), null,
      CardTest(), EdgeTest(), HBoxTest(), VBoxTest(), PaneTest(), null,
      MenuTest(), TableTest(), TreeTest(), null,
      EditTextTest(), TextAreaTest(), FilePickerTest(), null,
    ]
  }

  Void doClick(BasePage frame) {
    frame.run
  }
  
  Void main() {
    Frame {
      ScrollPane {
        VBox {
          padding = Insets(40)
          spacing = 15f
          Label {
            text = "Vase UI"
            style = "h1"
          },;
          
          v := it
          frames.each |p| {
            if (p == null) {
              v.add(RectView { layout.height = 3f })
              lret
            }
            b := Button {
                style = "flatButton"
                textAlign = Align.begin
                text = p.typeof.name
                onClick { doClick(p) }
            }
            v.add(b)
          }
        },
      },
    }.show
  }
}
