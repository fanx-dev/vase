using vaseGui
using vaseClient


@Js
class FilePickerTest : BasePage
{
  private Obj[]? files

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
            this.files = files
          }
        }
      },

      Button {
        text = "Upload"
        onClick {
          upload
        }
      }
    }
  }

  async Void upload() {
    if (files == null) return
    Uri url := `http://localhost:8080/util/Upload/saveFile`

    multiPart := [ "file1" : files[0], "name" : "abc" ]
    res := await HttpReq { uri = url; }.post(multiPart)
    echo("result: $res")
  }
}