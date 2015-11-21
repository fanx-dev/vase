Fanvas (old name is fangfx)
=======
A cross-platform Fantom framework for creating GUI or game on mobile and desktop.


Feature
-------
- Full features 2D Graphics API
- Lightweight GUI widget system
- Fantom OpenGL/WebGL binding
- Cross-platform support Java2D/SWT/Android/Javascript


Run on Android
-------

I. Bootstrap compile Fantom (http://fantom.org/doc/docTools/Bootstrap#script)
  1.Clone my fork https://bitbucket.org/chunquedong/fan-1.0
  2.directory tree
      dev/
        rel/
          bin/
          lib/
          ...
        fan/
          bin/
          lib/
          src/
          ...
  3.set os env
  export java_home=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

  4.set jdkHome(options)
   /etc/build/config.props：
  jdkHome=file:/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/

  5.start compile
  rel/bin/fan rel/adm/bootstrap.fan -skipPull

  6.copy new lib
  cp -rf fan/lib rel/

  7.compile again
  rel/bin/fan rel/adm/bootstrap.fan -skipPull

II. compile fanGx lib and Android Demo
  1.copy android jar
  copy fanGfx/lib/*.jar file to fan/lib/java/ext/

  2.build project
  fan/bin/fan /Users/yangjiandong/workspace/code/fanGfx/build.fan

  3.pack to jar file
  fan/bin/fan /Users/yangjiandong/workspace/code/fanGfx/androidDemo/build.fan dist

  4.run Android project from Eclipse ADT from fanGfx/androidDemo/android/

Setting LWJGL
-------
1. copy all .jar to fanHome/lib/java/ext/
2. modify fanHome/ect/sys/congif.proops:
  java.options=-Xmx512M -Djava.library.path=yourPath/lib/lwjgl-2.7.1/native/windows

Run WebGL on Browser
-------
1. Get a browser that support WegGL
2. Modify and run /test3d/startup.bat
3. Go to http://localhost:8080/ with your browser.


