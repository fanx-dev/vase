// To change this License template, choose Tools / Templates
// and edit Licenses / FanDefaultLicense.txt
//
// History:
//   2020-5-4 yangjiandong Creation
//

using vaseGraphics
using concurrent

**
** ImageLoader
**
class ImageLoader
{
  private static Void load(Image img, Uri uri, [Str:Obj]? options, |Image|? onLoad) {
    task := HttpReq {
        it.uri = uri
        decoder = |InStream in->Obj?| {
            Image.fromStream(in)
        }
        useCache := true
        if (options != null) {
          if (options.containsKey("nocache")) {
            useCache = false
          }
        }
        it.useCache = useCache
        it.headers["User-Agent"] = "vase/1.0"
    }.get
    task.then |HttpRes? res, Err? err| {
      if (res != null) {
        Image nImage := res.content
        //echo(nImage.size)
        img._swapImage(nImage)
        onLoad?.call(img)
      }
    }
  }
  
  static Void init() {
    loadImage := |Image img, Uri uri, [Str:Obj]? options, |Image|? onLoad| {
      load(img, uri, options, onLoad)
    }
    
    Actor.locals["vaseWindow.loadImage"] = loadImage
  }
}
