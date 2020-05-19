


using vaseGui
using vaseGraphics

@Js
class ImageViewTest : BasePage
{
  protected override Widget view() {
    VBox {
      ImageView {
        uri = Env.cur.runtime == "js" ? `img/image.png` : `fan://vaseDemo/res/image.png`
        scaleType = fitWidth
        mask = maskCircle
        layout.width = 100
        layout.height = 100
        onClick { Toast("hello world").show(it) }
      },
      Button {
        text = "Image Button"
        uri := Env.cur.runtime == "js" ? `img/image.png` : `fan://vaseDemo/res/image.png`
        setStyle(ImageButtonStyle { image = Image.fromUri(uri) })
        onClick { Toast("hello world").show(it) }
        layout.height = 250
        layout.width = 250
        padding = Insets(50)
      },
      ImageView {
        uri = Env.cur.runtime == "js" ? `img/image.png` : `fan://vaseDemo/res/image.png`
        scaleType = fitWidth
        mask = maskCircle
        layout.height = Layout.matchParent
        setDragable
      },
    }
  }
}