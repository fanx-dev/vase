package fan.fanAndroid;

import fan.concurrent.Actor;
import fan.fanWt.Toolkit;
import fan.fanWt.View;
import fan.fanWt.Window;
import android.content.Context;

public class AndroidEnvPeer {
  public static AndroidEnvPeer make(AndroidEnv self)
  {
    AndroidEnvPeer peer = new AndroidEnvPeer();
    return peer;
  }

  public static void init(Context context)
  {
    Actor.locals().set("fan2d.env", AndGfxEnv.instance);
    Actor.locals().set("fanWt.env", new AndToolkit(context));
  }

  static class AndToolkit extends Toolkit
  {
    Context context;
    public AndToolkit(Context context)
    {
      this.context = context;
    }
    
    @Override
    public Window build(View view) {
      return new AndView(context, view);
    }
  }
}
