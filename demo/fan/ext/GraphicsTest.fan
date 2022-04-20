


using vaseGui
using vaseGraphics

@Js
class Canvas : Widget {

  Image? image0
  Image? image1
  Image? image2
  Image? image3
  Image? image4
  Bool inited = false

  new make() {
    image0 = Image.fromUri(Uri("fan://vaseDemo/res/image.png"))
    image4 = Image.fromUri(Uri("fan://vaseDemo/res/image.png"))
  }

  override protected  Void doPaint(Rect clip, Graphics canvas) {

      if (!inited && image0.isReady && image4.isReady) {
        inited = true;
        c := image0.getPixel(76, 30)
        echo(c.toHex)


        image1 = Image.make(Size(300, 300))
        image1.paint |g| {
          g.drawRect(0, 0, 10, 10)
        }


        image2 = Image.make(Size(300, 300))
        for (i:= 0; i<100; ++i) {
          image2.setPixel(i, i, 0xFF_CC_88_00)
        }
        c0 := image2.getPixel(1, 1)
        if (c0 != 0xFF_CC_88_00) {
          echo("ERROR:$c0.toHex")
        }


        image3 = Image.make(Size(300, 300))
        image3.paint |g| {
          g.drawImage(image0, 0, 0)
          g.drawRect(0, 0, 10, 10)
        }
        for (i:= 0; i<100; ++i) {
          image3.setPixel(i, i, 0xFF_CC_88_00)
        }
        c3 := image3.getPixel(76, 30)
        echo(c3.toHex)

        for (i:= 0; i<100; ++i) {
          image4.setPixel(i, i, 0xFF_CC_88_00)
        }
      }

      if (!inited) return

      canvas.drawImage(image0, 0, 0)
      canvas.drawImage(image1, 300, 0)
      canvas.drawImage(image2, 0, 300)
      canvas.drawImage(image3, 300, 300)
      canvas.drawImage(image4, 0, 600)

      canvas.pen = Pen { it.width = 4 }
      canvas.brush = Color.red
      canvas.drawLine(0, 300, 600, 300)
      canvas.drawLine(300, 0, 300, 600)
  }
}

@Js
class GraphicsTest : BasePage
{
  protected override Widget view() {
    Canvas
    {
      layout.width = Layout.matchParent
      layout.height = Layout.matchParent
    }
  }
}