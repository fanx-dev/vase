// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-17 yangjiandong Creation
//

using vaseGui

@Js
class BubbleViewTest : BasePage
{
  protected override Widget view() {
    Str[] list := [,]
    100.times { list.add("item$it") }

    return ListView {
      model = BubbleListAdapter(list)
      refreshTip = ProgressView {
        layout.hAlign = Align.center
        layout.height = 60
        layout.width = 60
      }
    }
  }
}


@Js
class BubbleListAdapter : ListAdapter
{
  protected Obj[] list

  new make(Obj[] list) {
    this.list = list
  }

  override Int size() { list.size }

  protected override Obj getData(Int i) { list[i] }
  
  protected override Int getType(Int i, Obj data) { i % 2 }

  protected override Void bind(Widget w, Obj data) {
    Pane p := w
    TextView l := p.getChild(0)
    l.text = data.toStr
  }

  protected override Widget newView(Int type) {
    //echo("new view")
    Pane {
        style = type == 0 ? "bubbleTL" : "bubbleTR"
        padding = Insets(40)
        margin = Insets(40)
        layout.width = Layout.wrapContent
        layout.hAlign = type == 0 ? Align.begin : Align.end
        
        TextView {
           layout.width = Layout.wrapContent
        },
    }
  }
}