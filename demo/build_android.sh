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
