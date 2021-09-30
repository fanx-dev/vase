using vaseGui

class TestScript {
  Widget view() {
    VBox
    {
      Button {
        text = "Push Button";
        onClick { Toast("hello world").show(it) }
      },
    }
  }
}
