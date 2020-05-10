

fanb pod.props

fan compilerJs::Dump sys > cordovaDemo/www/js/fanx.js
fan compilerJs::Dump std >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump concurrent >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump util >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump vaseMath >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump vaseGraphics >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump vaseWindow >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump vaseClient >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump vaseGui >> cordovaDemo/www/js/fanx.js
fan compilerJs::Dump vaseDemo > cordovaDemo/www/js/demo.js

cd cordovaDemo
cordova run browser
cd -
