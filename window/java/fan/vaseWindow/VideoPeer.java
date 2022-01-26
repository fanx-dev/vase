package fan.vaseWindow;

import java.awt.EventQueue;

public class VideoPeer {

    public static VideoPeer make(Video self) {
        VideoPeer peer = new VideoPeer();
        return peer;
    }

    boolean play(Video self, long loop, fan.std.Map options) {
        return false;
    }

    void pause(Video self) {
    }

    void doSetup(Video self, Window win) {
        //System.out.println("unsupport video");
        EventQueue.invokeLater(new Runnable()
          {
            public void run()
            {
              self.fireEvent("unsupport");
            }
          });
    }

    void remove(Video self) {
    }

    void finalize(Video self) {
    }
}
