using vaseGui

@Js
class FilePickerTest : BasePage
{
  protected override Widget view() {
    VBox {
      label := TextView { text = "Hello" }
      label,
      Button {
        text = "Find File"
        onClick {
          getRootView.host.fileDialog("image/*") |files| {
            label.text = files.toStr
            label.relayout
          }
        }
      },
    }
  }
}