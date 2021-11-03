package fan.vaseWindow;

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
        System.out.println("unsupport video");
    }

    void remove(Video self) {
    }

    void finalize(Video self) {
    }
}
