// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-5 yangjiandong Creation
//

**
** TimeDialog
**
@Js
class TimeDialog : VBox, Dialog
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
        it.spacing = 80
        Button {
          it.id = "timeDialog_ok"
          it.style = "flatButton"
          it.onClick {
            this.close
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
            this.close
            onAction?.call(null)
          };
          it.text = cancelText
        }
        hb.add(bt)
    }
    
    spinnerHour = Spinner{ it.layout.width = Layout.matchParent}
    24.times { spinnerHour.items.add("$it") }
    spinnerHour.selIndex = 12
        
    spinnerMinute = Spinner{ it.layout.width = Layout.matchParent}
    60.times { spinnerMinute.items.add("$it") }
    spinnerMinute.selIndex = 30
        
    hb2 := HBox {
        spinnerHour, spinnerMinute
    }

    //this.add(label)
    this.add(hb2)
    this.add(RectView { it.layout.height = 3; it.margin = Insets(100, 6, 0, 6) })
    this.add(hb)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.end

    this.layout.width = Layout.matchParent//dpToPixel(500f)
    //padding = Insets(30, 100)
  }
}


**
** DateDialog
**
@Js
class DateDialog : VBox, Dialog
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
        it.spacing = 80
        Button {
          it.id = "timeDialog_ok"
          it.style = "flatButton"
          it.onClick {
            this.close
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
            this.close
            onAction?.call(null)
          };
          it.text = cancelText
        }
        hb.add(bt)
    }
    
    baseYear = defDate.year - 80
    spinnerYear = Spinner{ it.layout.width = Layout.matchParent}
    100.times {
        year := baseYear+it
        spinnerYear.items.add("$year")
    }
    spinnerYear.selIndex = defDate.year - baseYear

    spinnerMonth = Spinner{ it.layout.width = Layout.matchParent}
    12.times { spinnerMonth.items.add("${it+1}") }
    spinnerMonth.selIndex = defDate.month.ordinal

    spinnerDay = Spinner{ it.layout.width = Layout.matchParent}
    31.times { spinnerDay.items.add("${it+1}") }
    spinnerDay.selIndex = defDate.day-1
    
    hb2 := HBox { 
        spinnerYear, spinnerMonth, spinnerDay
    }

    //this.add(label)
    this.add(hb2)
    this.add(RectView { it.layout.height = 3; it.margin = Insets(100, 6, 0, 6) })
    this.add(hb)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.end

    this.layout.width = Layout.matchParent//dpToPixel(500f)
    //padding = Insets(30, 100)
  }
}
