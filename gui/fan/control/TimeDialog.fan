// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-5 yangjiandong Creation
//

**
** TimeDialog
**
class TimeDialog : VBox
{  
  |TimeOfDay?|? onAction
  private Spinner spinnerHour
  private Spinner spinnerMinute
  
  private TimeOfDay time() {
    TimeOfDay(spinnerHour.selIndex, spinnerMinute.selIndex)
  }

  new make(Str okText := "OK", Str? cancelText := null)
  {
    this.style = "dialog"
    
    hb := HBox {
        it.spacing = 80f
        Button {
          it.id = "timeDialog_ok"
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            onAction?.call(time)
          };
          it.text = okText
        },
    }
    
    if (cancelText != null) {
        bt := Button {
          it.id = "timeDialog_cancel"
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            onAction?.call(null)
          };
          it.text = cancelText
        }
        hb.add(bt)
    }
    
    hb2 := HBox {
        spinnerHour = Spinner{ it.layout.width = Layout.matchParent},;
        24.times { spinnerHour.items.add("$it") }
        spinnerHour.selIndex = 12

        spinnerMinute = Spinner{ it.layout.width = Layout.matchParent},;
        60.times { spinnerMinute.items.add("$it") }
        spinnerMinute.selIndex = 30
    }

    //this.add(label)
    this.add(hb2)
    this.add(RectView { it.layout.height = 3.0; it.margin = Insets(100, 0, 0, 0) })
    this.add(hb)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.end

    this.layout.width = Layout.matchParent//dpToPixel(500f)
    //padding = Insets(30, 100)
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    this.focus
    root.modal = 2
    overlayer.relayout
    this.moveInAnim(Direction.down).start
  }
}


**
** DateDialog
**
class DateDialog : VBox
{  
  |Date?|? onAction
  private Spinner spinnerYear
  private Spinner spinnerMonth
  private Spinner spinnerDay
  private Int baseYear := 0
  
  private Date date() {
    d := Date(spinnerYear.selIndex+baseYear
        , Month.vals[spinnerMonth.selIndex], spinnerDay.selIndex+1)
    //echo(d)
    return d
  }

  new make(Str okText := "OK", Str? cancelText := null, Date defDate := Date.today)
  {
    this.style = "dialog"
    
    hb := HBox {
        it.spacing = 80f
        Button {
          it.id = "timeDialog_ok"
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            date
            onAction?.call(date)
          };
          it.text = okText
        },
    }
    
    if (cancelText != null) {
        bt := Button {
          it.id = "timeDialog_cancel"
          it.style = "flatButton"
          it.onClick {
            this.moveOutAnim(Direction.down).start
            onAction?.call(null)
          };
          it.text = cancelText
        }
        hb.add(bt)
    }
    
    baseYear = defDate.year - 80
    hb2 := HBox { 
        spinnerYear = Spinner{ it.layout.width = Layout.matchParent},;
        100.times {
            year := baseYear+it
            spinnerYear.items.add("$year")
        }
        spinnerYear.selIndex = defDate.year - baseYear

        spinnerMonth = Spinner{ it.layout.width = Layout.matchParent},;
        12.times { spinnerMonth.items.add("${it+1}") }
        spinnerMonth.selIndex = defDate.month.ordinal

        spinnerDay = Spinner{ it.layout.width = Layout.matchParent},;
        31.times { spinnerDay.items.add("${it+1}") }
        spinnerDay.selIndex = defDate.day-1
    }

    //this.add(label)
    this.add(hb2)
    this.add(RectView { it.layout.height = 3.0; it.margin = Insets(100, 0, 0, 0) })
    this.add(hb)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.end

    this.layout.width = Layout.matchParent//dpToPixel(500f)
    //padding = Insets(30, 100)
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    this.focus
    root.modal = 2
    overlayer.relayout
    this.moveInAnim(Direction.down).start
  }
}
