package fan.vaseClient;


public class PurchasePeer {

    public static PurchasePeer instance = new PurchasePeer();

    static PurchasePeer make(Purchase self) {
        return instance;
    }
    boolean start(Purchase self, String name, long type) {
        self.finish(name, 0);
        return false;
    }
}
