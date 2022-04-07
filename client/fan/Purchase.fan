

**
** Payments - In-App Purchase 
**
class Purchase
{
  //1:success, 0:fail
  |Str, Int|? onFinished
  
  //0:purchase 1:restore purchase
  native Bool start(Str name, Int type)
  
  protected Void finish(Str name, Int res) {
    onFinished?.call(name, res)
  }
}
