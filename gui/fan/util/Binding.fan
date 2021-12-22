using vaseWindow

mixin Bindable {
    abstract EventListeners onStateChanged()
}

class Binding {
    **
    ** bind model to view
    **
    static Bool bindTo(Bindable model, Field field, Widget view) {
        val := field.get(model)
        val = (val == null) ? "" : val.toStr

        if (view is EditText) {
            editText := view as EditText
            editText.text = val
            editText.onFocusChanged.add |e| {
              focused := e.data
              if (!focused)
              {
                if (field.type == Str#) {
                    field.set(model, editText.text)
                }
                else {
                    fromStrM := field.type.method("fromStr", false)
                    if (fromStrM != null) field.set(model, fromStrM.call(editText.text))
                }
              }
            }
            model.onStateChanged.add |StateChangedEvent e| {
               if (e.field == field) {
                   editText.text = val
               }
            }
            return true
        }
        else if (view is ToggleButton) {
            button := view as ToggleButton
            button.selected = field.get(model)
            button.onStateChanged.add |StateChangedEvent e| {
              if (e.field == ToggleButton#selected)
              {
                field.set(model, e.newValue)
              }
            }
            model.onStateChanged.add |StateChangedEvent e| {
               if (e.field == field) {
                   button.selected = field.get(model)
               }
            }
            return true
        }
        else if (view is Label) {
            label := view as Label
            label.text = val
            model.onStateChanged.add |StateChangedEvent e| {
                if (e.field == field) {
                   label.text = val
                }
            }
            return true
        }
        return false
    }

    **
    ** bind model to view which find by field name
    **
    static Bool bindByName(Widget root, Bindable model, Field field) {
        view := root.findById(field.name)
        return bindTo(model, field, view)
    }

    **
    ** inject widget ref to controller by name
    **
    static Int inject(Widget view, Obj controller) {
        count := 0
        controller.typeof.fields.each |field| {
            if (field.type.fits(Widget#)) {
                widget := view.findById(field.name)
                if (widget != null) {
                    field.set(controller, widget)
                    ++count
                }
            }
        }
        return count
    }
}