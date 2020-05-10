using vaseGui

@Js
class FilePickerTest : BasePage
{
  protected override Widget view() {
    VBox {
      label := Label { text = "Hello" }
      label,
      Button {
        text = "Find File"
        onClick {
          getRootView.host.fileDialog("") |files| {
            label.text = files.toStr
          }
        }
      },
    }
  }
}