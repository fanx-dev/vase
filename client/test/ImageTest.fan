using vaseGui
using vaseClient

@Js
class ImageViewTest : BaseTestWin
{
  protected override Widget build() {
    ImageLoader.init
    return ImageView {
      id = "image"
      uri = `https://p.ssl.qhimg.com/t01512497e6e7151b1f.png`
      imagePrefWidth = 1000f
      imagePrefHeight = 800f
      //scaleType = stretch
    }
  }
}