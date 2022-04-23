// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-9 yangjiandong Creation
//

**
** Dialog
**
@Js
mixin Dialog
{  
  virtual This show(Widget parent)
  {
    root := parent.getRootView
    overlayer := root.topOverlayer(2)
    overlayer.add(self)
    root.clearFocus
    overlayer.relayout
    
    if (animType == 1)
        self.expandAnim().start
    else
        self.moveInAnim(Direction.down).start
    return this
  }
  
  protected virtual Widget self() { (Widget)this }
  protected virtual Int animType() { 0 }
  
  Void close() {
    parent := self.parent
    if (animType == 1) {
        annim := self.shrinkAnim
        annim.whenDone.add {
            parent.detach
        }
        annim.start
    }
    else {
        annim := self.moveOutAnim(Direction.down)
        annim.whenDone.add {
            parent.detach
        }
        annim.start
    }
  }
}
