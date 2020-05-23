package fan.vaseClient;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.CookieHandler;
import java.net.CookieManager;
import java.net.HttpCookie;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;
import java.util.concurrent.*;
import java.io.File;

import fan.sys.*;
import fan.concurrent.*;
import fanx.interop.*;

class HttpReqPeer {

  Storage storage = StoragePeer.open(StoragePeer.baseStorePath+"httpCache/");

  public static boolean debug = false;
  public static boolean disconnect = false;
  static ExecutorService threadPool;

  static {
    threadPool = Executors.newCachedThreadPool();
    initCookie();
  }

  static HttpReqPeer make(HttpReq self) {
    return new HttpReqPeer();
  }

  Promise send(final HttpReq self, final String method, final Object content) {
    final Promise promise = Promise$.make();
    threadPool.execute(new Runnable() {
      @Override
      public void run() {
        String urlStr = self.uri.toStr();
        boolean useCache = false;
        if (self.useCache() && "GET".equals(method)) {
          useCache = true;
          try {
            Object c = storage.get(urlStr, self.decoder == null);
            if (c != null) {
               HttpRes res = HttpRes.make();
               res.status = 0;
               if (self.decoder != null && c instanceof fan.std.Buf) {
                 res.content = self.decoder.call(((fan.std.Buf)c).in());
               }
               else {
                 res.content = c;
               }
               promise.complete(res, true);
               System.out.println("use cache");
               return;
            }
          }
          catch (Throwable e) { e.printStackTrace(); }
        }
        doRequest(self, urlStr, method, content, promise, useCache);
      }
    });
    return promise;
  }

  void doRequest(HttpReq self, String urlStr, String method, Object content, Promise promise, boolean useCache) {
    URL url = null;
    HttpURLConnection connection = null;
    try {
      if (debug) {
        System.out.println(urlStr);
      }
      url = new URL(urlStr);      
      connection = (HttpURLConnection) url.openConnection();
      connection.setRequestMethod(method);

      setConnection(self, connection);
      
      if (content != null) {
        writeContent(connection, content);
      }

      HttpRes res = HttpRes.make();
      Object rawContent = readRes(self, res, connection, useCache);
      promise.complete(res, true);

      if (useCache) {
        try {
          storage.set(urlStr, rawContent);
        }
        catch (Throwable e) { e.printStackTrace(); }
      }

    } catch (Exception e) {
      e.printStackTrace();
      promise.complete(Err.make(e), false);
    }
    finally {
      try {
        if (connection != null && disconnect) {
          connection.disconnect();
        }
      }
      catch (Exception e) {}
    }
  }

  private void setConnection(HttpReq self, HttpURLConnection connection) {
    connection.setConnectTimeout((int)self.timeout);
    connection.setReadTimeout((int)self.timeout);

    connection.setDoInput(true);
    connection.setDoOutput(true);
    //connection.setInstanceFollowRedirects(true);

    self.headers.each(
      new Func() {
        public Object call(Object v, Object k) {
          connection.setRequestProperty((String)k, (String)v);
          return null;
        }

    		// @Override
    		// public long arity() {
    		// 	return 2;
    		// }
      }
    );
  }

  private void writeContent(HttpURLConnection connection, Object content) throws IOException {
    
    if (content instanceof fan.std.File) {
      connection.connect();
      OutputStream out = connection.getOutputStream();
      try {
        fan.std.File file = (fan.std.File)content;
        fan.std.InStream in = file.in();
        fan.std.OutStream fout = Interop.toFan(out);
        in.pipe(fout);
        fout.flush();
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        out.close();
      }
    }
    else if (content instanceof fan.std.Map) {
      MultipartUtility multipart = new MultipartUtility(connection);
      fan.std.Map map = (fan.std.Map)content;
      map.each(new fan.sys.Func() {
        public Object call(Object v, Object k) {
          if (v instanceof String) {
            multipart.addFormField((String)k, (String)v);
          }
          else {
            fan.std.File file = (fan.std.File)v;
            try {
              multipart.addFilePart((String)k, new File(file.osPath()));
            }
            catch (IOException e) {
              throw new fan.sys.Err(e);
            }
          }
          return null;
        }
      });
      multipart.finish();
      //List<String> response = multipart.finish();
    }
    else {
      connection.connect();
      OutputStream out = connection.getOutputStream();
      BufferedOutputStream os = new BufferedOutputStream(out);
      try {
        os.write((content.toString()).getBytes("UTF-8"));
        os.flush();
      } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      } catch (IOException e) {
        e.printStackTrace();
      } finally {
        out.close();
      }
    }
  }

  private Object readRes(HttpReq self, HttpRes res, HttpURLConnection connection
      , boolean useCache) throws IOException {
    res.status = connection.getResponseCode();

    java.util.Map<String,List<String>> headers = connection.getHeaderFields();
    if (headers != null) {
        for (java.util.Map.Entry<String,List<String>> e : headers.entrySet()) {
          String k = e.getKey();
          if (k == null) continue;
          String v = null;
          if (e.getValue() != null && e.getValue().size() > 0) {
            v = e.getValue().get(0);
          }
          if (v == null) v = "";
          res.headers().set(k, v);
          //System.out.println(k+":"+v);
        }
    }

    Object rawContent = null;
    InputStream is = null;
    try {
      is = connection.getInputStream();
      if (self.decoder != null) {
        if (useCache) {
            fan.std.Buf buf = Interop.toFan(is).readAllBuf();
            res.content = self.decoder.call(buf.in());
            buf.seek(0);
            rawContent = buf;
        }
        else {
            res.content = self.decoder.call(Interop.toFan(is));
        }
      }
      else {
        res.content = streamToString(is);
        rawContent = res.content;
      }
      is.close();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    finally {
      is.close();
    }

    return rawContent;
  }

  //////////////////////////////////////////////////////////////////////
  // cookie
  //////////////////////////////////////////////////////////////////////

  public static void initCookie() {
    CookieManager cookieManager = new CookieManager();
    CookieHandler.setDefault(cookieManager);
  }

  public static String getCookie(String uri, String name) {
    CookieManager cookieManager = (CookieManager) CookieHandler
        .getDefault();
    try {
      List<HttpCookie> list = cookieManager.getCookieStore().get(
          new URI(uri));
      for (HttpCookie c : list) {
        if (c.getName().equals(name)) {
          return c.getValue();
        }
      }
    } catch (URISyntaxException e) {
      e.printStackTrace();
    }
    return null;
  }

  public static void addCookie(String uri, String name, String value) {
    addCookie(uri, name, value, "/");
  }

  public static void addCookie(String uri, String name, String value, String path) {
    CookieManager cookieManager = (CookieManager) CookieHandler
        .getDefault();
    try {
      URI u = new URI(uri);
      HttpCookie c = new HttpCookie(name, value);
      c.setPath(path);
      c.setDomain(u.getHost());
      cookieManager.getCookieStore().add(new URI(uri), c);
    } catch (URISyntaxException e) {
      e.printStackTrace();
    }
  }

  public static void clearCookie() {
    CookieManager cookieManager = (CookieManager) CookieHandler
        .getDefault();
    cookieManager.getCookieStore().removeAll();
  }

  //////////////////////////////////////////////////////////////////////
  // util

  public static String streamToString(InputStream is) throws IOException {
    BufferedReader in = new BufferedReader(new InputStreamReader(is,
        "UTF-8"));
    String line = null;
    StringBuilder sb = new StringBuilder();

    while ((line = in.readLine()) != null) {
      sb.append(line);
    }
    return sb.toString();
  }
}