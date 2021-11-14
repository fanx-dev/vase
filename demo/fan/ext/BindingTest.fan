using vaseGui
using vaseWindow


class BindModel : Bindable {
  override EventListeners onStateChanged := EventListeners()

  Str name := "abc"  {
    set
    {
      oldVal := &name
      if (oldVal != it) {
        &name = it
        onStateChanged.fire(StateChangedEvent(oldVal, it, #name, this))
      }
    }
  }

  Bool isOk := true {
    set
    {
      oldVal := &isOk
      if (oldVal != it) {
        &isOk = it
        onStateChanged.fire(StateChangedEvent(oldVal, it, #isOk, this))
      }
    }
  }
}

@Js
class BindingTest : BasePage
{
  BindModel model := BindModel()
  Label? label
  Button? button

  protected override Widget view() {
    VBox {
      margin = Insets(10)
      layout.height = Layout.matchParent
      Label {
        id = "label"
        text = "H1"
      },
      EditText {
        id = "name"
        hint = "EditText"
      },
      ToggleButton {
        id = "isOk"
        text = "switch"
      },
      Button {
        id = "button"
        text = "Button";
        onClick { Toast("$model.name, $model.isOk").show(it) }
      },
    }
  }

  protected override Void init(Frame frame) {
    Binding.bindByName(frame, model, BindModel#name)
    Binding.bindByName(frame, model, BindModel#isOk)
    Binding.inject(frame, this)
    Binding.bindTo(model, BindModel#name, label)
  }
}
