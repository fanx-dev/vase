cd ./public/fan

FAN_HOME=/Users/yangjiandong/workspace/code/fanx/env

jfan='java -Xmx512M -XstartOnFirstThread -cp '$FAN_HOME'/lib/java/fanx.jar -Dfan.home='$FAN_HOME/' fanx.tools.Fan'

echo $jfan

#$jfan Colour.fan
#$jfan Fan3dMain.fan
#$jfan Movement.fan
#$jfan RealObject.fan
$jfan Textures.fwt
#$jfan Triangle.fan

echo "end"
