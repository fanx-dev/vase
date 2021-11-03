using vaseWindow
using vaseGui

@Js
class VideoTest : BasePage
{
  VideoView? videoView


  protected override Void init(Frame frame) {
  }

  protected override Widget view() {
    VBox {
      Button {
        text = "Play"
        onClick {
          play
        }
      },
      videoView = VideoView {
        uri = `fan://vaseDemo/res/0001-0030.mp4`
        layout.height = 400
        video.onEvent = |str| { Toast("$str").show(videoView) }
      },
    }
  }

  Void play() {
    videoView.video.play(0)
  }
}