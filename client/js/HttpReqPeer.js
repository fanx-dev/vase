//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   8 Jan 09   Andy Frank  Creation
//   20 May 09  Andy Frank  Refactor to new OO model
//   8 Jul 09   Andy Frank  Split webappClient into sys/dom
//

fan.fanvasClient.HttpReqPeer = fan.sys.Obj.$extend(fan.sys.Obj);

fan.fanvasClient.HttpReqPeer.prototype.$ctor = function(self) {}

fan.fanvasClient.HttpReqPeer.prototype.send = function(self, method, content, f)
{
  return new Promise(function(resolve, reject) {
    fan.fanvasClient.HttpReqPeer.doRequest(self, method, content, resolve);
  });
}

fan.fanvasClient.HttpReqPeer.doRequest = function(self, method, content, f)
{
  var xhr = new XMLHttpRequest();
  var buf;
  var view;
  xhr.open(method.toUpperCase(), self.m_uri.m_str, self.m_async);
  if (self.m_asynch)
  {
    xhr.onreadystatechange = function ()
    {
      if (xhr.readyState == 4)
        f.call(fan.fanvasClient.HttpReqPeer.makeRes(xhr));
    }
  }
  var ct = false;
  var k = self.m_headers.keys();
  for (var i=0; i<k.size(); i++)
  {
    var key = k.get(i);
    if (fan.sys.Str.lower(key) == "content-type") ct = true;
    xhr.setRequestHeader(key, self.m_headers.get(key));
  }
  xhr.withCredentials = self.m_withCredentials;
  if (content == null)
  {
    xhr.send(null);
  }
  else if (fan.sys.ObjUtil.$typeof(content) === fan.sys.Str.$type)
  {
    // send text
    if (!ct) xhr.setRequestHeader("Content-Type", "text/plain");
    xhr.send(content);
  }
  else if (content instanceof fan.sys.Buf)
  {
    // send binary
    if (!ct) xhr.setRequestHeader("Content-Type", "application/octet-stream");
    buf = new ArrayBuffer(content.size());
    view = new Uint8Array(buf);
    view.set(content.m_buf.slice(0, content.size()));
    xhr.send(view);
  }
  else
  {
    throw fan.sys.Err.make("Can only send Str or Buf: " + content);
  }
}

fan.fanvasClient.HttpReqPeer.makeRes = function(xhr)
{
  var res = fan.fanvasClient.HttpRes.make();
  res.m_status  = xhr.status;
  res.m_content = xhr.responseText;

  var all = xhr.getAllResponseHeaders().split("\n");
  for (var i=0; i<all.length; i++)
  {
    if (all[i].length == 0) continue;
    var j = all[i].indexOf(":");
    var k = fan.sys.Str.trim(all[i].substr(0, j));
    var v = fan.sys.Str.trim(all[i].substr(j+1));
    res.m_headers.set(k, v);
  }

  return res;
}
/*
fan.fanvasClient.HttpReqPeer.prototype.encodeForm = function(self, form)
{
  var content = ""
  var k = form.keys();
  for (var i=0; i<k.size(); i++)
  {
    if (i > 0) content += "&";
    content += encodeURIComponent(k.get(i)) + "=" +
               encodeURIComponent(form.get(k.get(i)));
  }
  return content;
}
*/
