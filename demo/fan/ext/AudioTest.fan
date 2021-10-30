using vaseWindow
using vaseGui

@Js
class AudioTest : BasePage
{
  Sound? sound
  Speech? speech

  protected override Void init(Frame frame) {
    sound = Sound(`fan://vaseDemo/res/esn7f-80gbn.wav`)
    sound.load

    speech = Speech()
  }

  protected override Widget view() {
    VBox {
      Button {
        text = "PlaySound"
        onClick {
          play
        }
      },

      Button {
        text = "TTS"
        onClick {
          speak()
        }
      },
    }
  }

  Void play() {
    sound.play(0)
  }

  Void speak() {
    text := "Hello世界"
    speech.speak(text)
  }
}