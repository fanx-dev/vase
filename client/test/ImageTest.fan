using vaseGui
using vaseClient

@Js
class ImageViewTest : GuiTest
{
  protected override Widget build() {
    ImageLoader.init
    return ImageView {
      id = "image"
      uri = `https://p.ssl.qhimg.com/t01512497e6e7151b1f.png`
      layout.height = Layout.matchParent
    }
  }
}