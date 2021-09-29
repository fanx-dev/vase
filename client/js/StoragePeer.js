
//
// Copyright (c) 2010, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   10 Aug 10  Andy Frank  Created
//

fan.vaseClient.StoragePeer = function() {};

fan.vaseClient.StoragePeer.cur = function()
{
  if (fan.vaseClient.StoragePeer.$localStorage == null)
  {
    fan.vaseClient.StoragePeer.$localStorage = fan.vaseClient.LocalStorage.make();
  }
  return fan.vaseClient.StoragePeer.$localStorage;
}


fan.vaseClient.LocalStorage = fan.sys.Obj.$extend(fan.vaseClient.Storage);
fan.vaseClient.LocalStorage.prototype.$ctor = function(self) {}
fan.vaseClient.LocalStorage.prototype.$instance = null;

fan.vaseClient.LocalStorage.make = function() {
  self = new fan.vaseClient.LocalStorage();
  self.$instance = window.localStorage;
  return self;
}

//////////////////////////////////////////////////////////////////////////
// Access
//////////////////////////////////////////////////////////////////////////

fan.vaseClient.LocalStorage.prototype.size = function(self, key)
{
  return this.$instance.length;
}

fan.vaseClient.LocalStorage.prototype.key = function(self, index)
{
  return this.$instance.key(index);
}

fan.vaseClient.LocalStorage.prototype.get = function(self, key, text)
{
  return this.$instance.getItem(key);
}

fan.vaseClient.LocalStorage.prototype.set = function(self, key, val)
{
  this.$instance.setItem(key, val);
}

fan.vaseClient.LocalStorage.prototype.remove = function(self, key)
{
  this.$instance.removeItem(key);
}

fan.vaseClient.LocalStorage.prototype.clear = function(self)
{
  this.$instance.clear();
}

