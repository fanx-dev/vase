// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-9 yangjiandong Creation
//

**
** Dialog
**
mixin Dialog
{
  Void show(Widget parent)
  {
    root := parent.getRootView
    overlayer := root.topOverlayer
    overlayer.add(self)
    self.focus
    root.modal = 2
    overlayer.relayout
    self.moveInAnim(Direction.down).start
  }
  
  virtual Widget self() { (Widget)this }
  
  Void close() {
    self.moveOutAnim(Direction.down).start
  }
}
