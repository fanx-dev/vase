set -e

fanb pod.props

# to jar
fan build::JarDistMain vaseDemo vaseDemo::WinTest.main
cp vaseDemo.jar android/app/libs/

# run android
cd android
 ./gradlew installDebug
 adb shell am start -n com.example.fvdemo/com.example.fvdemo.MainActivity
cd -

fan compilerJs::Dump sys > cordovaDemo/www/js/sys.js
fan compilerJs::Dump std > cordovaDemo/www/js/std.js
fan compilerJs::Dump concurrent > cordovaDemo/www/js/concurrent.js
fan compilerJs::Dump util > cordovaDemo/www/js/util.js
fan compilerJs::Dump vaseGraphics > cordovaDemo/www/js/vaseGraphics.js
fan compilerJs::Dump vaseWindow > cordovaDemo/www/js/vaseWindow.js
fan compilerJs::Dump vaseMath > cordovaDemo/www/js/vaseMath.js
fan compilerJs::Dump vaseClient > cordovaDemo/www/js/vaseClient.js
fan compilerJs::Dump vaseGui > cordovaDemo/www/js/vaseGui.js
fan compilerJs::Dump vaseDemo > cordovaDemo/www/js/vaseDemo.js
