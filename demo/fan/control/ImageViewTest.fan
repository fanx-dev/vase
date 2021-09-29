


using vaseGui
using vaseGraphics
using vaseWindow

@Js
class ImageViewTest : BasePage
{
  protected override Widget view() {
    VBox {
      layout.height = Layout.matchParent
      ImageView {
        uri = Toolkit.cur.resFilePath("vaseDemo", "res/image.png").toUri
        scaleType = fitWidth
        mask = maskCircle
        layout.width = 200
        layout.height = 200
        onClick { Toast("hello world").show(it) }
      },
      Button {
        text = "Image Button"
        uri := Toolkit.cur.resFilePath("vaseDemo", "res/image.png").toUri
        setStyle(ImageButtonStyle { image = Image.fromUri(uri) })
        onClick { Toast("hello world").show(it) }
        layout.height = 200
        layout.width = 200
        padding = Insets(50)
      },
      ImageView {
        uri = Toolkit.cur.resFilePath("vaseDemo", "res/image.png").toUri
        scaleType = fitWidth
        //mask = maskCircle
        layout.height = Layout.matchParent
        setDragable
      },
    }
  }
}