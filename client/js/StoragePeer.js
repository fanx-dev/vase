
//
// Copyright (c) 2010, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   10 Aug 10  Andy Frank  Created
//

fan.vaseClient.StoragePeer = fan.sys.Obj.$extend(fan.sys.Obj);

//////////////////////////////////////////////////////////////////////////
// Construction
//////////////////////////////////////////////////////////////////////////

fan.vaseClient.StoragePeer.prototype.$ctor = function(self) {}
fan.vaseClient.StoragePeer.prototype.$instance = null;

fan.vaseClient.StoragePeer.cur = function(self)
{
  if (fan.vaseClient.StoragePeer.$localStorage == null)
  {
    fan.vaseClient.StoragePeer.$localStorage = fan.vaseClient.Storage.make();
    fan.vaseClient.StoragePeer.$localStorage.peer.$instance = window.localStorage;
  }
  return fan.vaseClient.StoragePeer.$localStorage;
}

//////////////////////////////////////////////////////////////////////////
// Access
//////////////////////////////////////////////////////////////////////////

fan.vaseClient.StoragePeer.prototype.size = function(self, key)
{
  return this.$instance.length;
}

fan.vaseClient.StoragePeer.prototype.key = function(self, index)
{
  return this.$instance.key(index);
}

fan.vaseClient.StoragePeer.prototype.get = function(self, key, text)
{
  return this.$instance.getItem(key);
}

fan.vaseClient.StoragePeer.prototype.set = function(self, key, val)
{
  this.$instance.setItem(key, val);
}

fan.vaseClient.StoragePeer.prototype.remove = function(self, key)
{
  this.$instance.removeItem(key);
}

fan.vaseClient.StoragePeer.prototype.clear = function(self)
{
  this.$instance.clear();
}

