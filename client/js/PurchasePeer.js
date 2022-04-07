

fan.vaseClient.PurchasePeer = function() {};

fan.vaseClient.PurchasePeer.instance = new fan.vaseClient.PurchasePeer();

fan.vaseClient.PurchasePeer.make = function() {
  return fan.vaseClient.PurchasePeer.instance;
}

fan.vaseClient.PurchasePeer.prototype.start = function(self, name, type)
{
  return false;
}