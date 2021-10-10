


using vaseGui
using vaseGraphics
using vaseWindow

@Js
class ImageViewTest : BasePage
{
  protected override Widget view() {
    VBox {
      layout.height = Layout.matchParent
      Label { text = "Clickable Circle ImageView:" },
      ImageView {
        uri = Uri("fan://vaseDemo/res/image.png")
        scaleType = fitHeight
        mask = maskCircle
        layout.width = 400
        layout.height = 200
        onClick { Toast("hello world").show(it) }
      },

      Label { text = "Button with Image background:" },
      Button {
        text = "Image Button"
        uri := Uri("fan://vaseDemo/res/image.png")
        setStyle(ImageButtonStyle { image = Image.fromUri(uri) })
        onClick { Toast("hello world").show(it) }
        layout.height = 200
        layout.width = 400
        padding = Insets(50)
      },

      Label { text = "Dragable ImageView:" },
      ImageView {
        uri = Uri("fan://vaseDemo/res/image.png")
        scaleType = fitWidth
        //mask = maskCircle
        layout.height = Layout.matchParent
        setDragable
      },
    }
  }
}