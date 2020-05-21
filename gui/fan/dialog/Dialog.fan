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
  Void show(Widget parent)
  {
    root := parent.getRootView
    overlayer := root.topOverlayer
    overlayer.add(self)
    root.clearFocus
    root.modal = 2
    overlayer.relayout
    
    if (animType == 1)
        self.expandAnim().start
    else
        self.moveInAnim(Direction.down).start
  }
  
  protected virtual Widget self() { (Widget)this }
  protected virtual Int animType() { 0 }
  
  Void close() {
    if (animType == 1)
        self.shrinkAnim.start
    else
        self.moveOutAnim(Direction.down).start
  }
}
