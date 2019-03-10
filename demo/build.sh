fan build.fan
fan build.fan dist

cd android
 ./gradlew installDebug
 adb shell am start -n com.example.fvdemo/com.example.fvdemo.MainActivity
cd -

