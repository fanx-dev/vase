cd ./public/fan

FAN_HOME=/Users/yangjiandong/workspace/code/fanCore/env

jfan='java -Xmx512M -XstartOnFirstThread -cp '$FAN_HOME'/lib/java/fanx.jar -Dfan.home='$FAN_HOME/' fanx.tools.Fan'

echo $jfan

#$jfan Colour.fan
#$jfan Fan3dMain.fan
#$jfan Movement.fan
#$jfan RealObject.fan
$jfan Textures.fan
#$jfan Triangle.fan

echo "end"
