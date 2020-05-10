


using vaseGui

@Js
class ImageViewTest : BasePage
{
  protected override Widget view() {
    return  ImageView {
      uri = Env.cur.runtime == "js" ? `img/image.png` : `fan://vaseDemo/res/image.png`
      imagePrefWidth = 1000f
      imagePrefHeight = 800f
      scaleType = fitWidth
      mask = maskCircle
      layout.height = Layout.matchParent
    }
  }
}