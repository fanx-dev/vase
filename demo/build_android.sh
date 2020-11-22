set -e

fanb pod.props

# to jar
fan build::Jar vaseDemo vaseDemo::Main.main
cp vaseDemo.jar android/app/libs/

# run android
cd android
 ./gradlew installDebug
 adb shell am start -n com.example.fvdemo/com.example.fvdemo.MainActivity
cd -
