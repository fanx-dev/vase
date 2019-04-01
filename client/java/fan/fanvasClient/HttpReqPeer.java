package fan.fanvasClient;

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

import fan.sys.*;
import fan.concurrent.*;

class HttpReqPeer {

  static boolean disconnect = false;
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
        doRequest(self, self.uri.toStr(), method, content, promise);
      }
    });
    return promise;
  }

  void doRequest(HttpReq self, String urlStr, String method, Object content, Promise promise) {
    URL url = null;
    HttpURLConnection connection = null;
    try {
      url = new URL(urlStr);
      
      connection = (HttpURLConnection) url.openConnection();
      connection.setRequestMethod(method);

      setConnection(self, connection);
      
      if (content != null) {
        setContent(connection, content);
      }

      HttpRes res = makeRes(connection);
      promise.complete(res);

    } catch (Exception e) {
      e.printStackTrace();
      promise.complete(Err.make(e));
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

    self.headers.each(
      new Func() {
        public Object call(Object v, Object k) {
          connection.setRequestProperty((String)k, (String)v);
          return null;
        }

    		@Override
    		public long arity() {
    			return 2;
    		}
      }
    );
  }

  private void setContent(HttpURLConnection connection, Object content) throws IOException {
    if (content instanceof String) {
      connection.connect();
      OutputStream out = connection.getOutputStream();
      BufferedOutputStream os = new BufferedOutputStream(out);
      try {
        os.write(((String)content).getBytes("UTF-8"));
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

  private HttpRes makeRes(HttpURLConnection connection) throws IOException {
    HttpRes res = HttpRes.make();
    res.status = connection.getResponseCode();

    String s = null;
    InputStream is = null;
    try {
      is = connection.getInputStream();
      s = streamToString(is);
      is.close();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    finally {
      is.close();
    }
    res.content = s;

    return res;
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