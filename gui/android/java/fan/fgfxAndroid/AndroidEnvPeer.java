package fan.fgfxAndroid;

import fan.concurrent.Actor;
import fan.fgfxWtk.Toolkit;
import fan.fgfxWtk.View;
import fan.fgfxWtk.Window;
import android.content.Context;

public class AndroidEnvPeer {
  public static AndroidEnvPeer make(AndroidEnv self)
  {
    AndroidEnvPeer peer = new AndroidEnvPeer();
    return peer;
  }

  public static void init(Context context)
  {
    Actor.locals().set("fgfx2d.env", AndGfxEnv.instance);
    Actor.locals().set("fgfxWtk.env", new AndToolkit(context));
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

    @Override
    public void callLater(long daly, fan.sys.Func f)
    {
      //TODO
    }
  }
}