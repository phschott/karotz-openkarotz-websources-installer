#!/bin/bash

source /usr/www/cgi-bin/utils.inc

# ffmpeg -vcodec rawvideo -f rawvideo -pix_fmt rgb565 -s 640x480 -i /dev/camera -ss 00:00:01  -r 1 -vframes 1 -y /tmp/%d.jpg
# --print-reply
function TakeSnapshot 
{  
   Log  "Snapshot" "Taking Snapshot"
   # --print-reply rend l'appel synchrone (on attend que la photo soit ecrite
   # avant de la lire), mais il ecrit la reponse D-Bus sur stdout : il faut la
   # jeter, sinon elle contamine la reponse HTTP avant les en-tetes
   # ("Parse Error: Invalid header token").
   dbus-send --system --type=method_call --print-reply --dest=com.mindscape.karotz.Webcam /com/mindscape/karotz/Webcam com.mindscape.karotz.KarotzInterface.takeSnapshot string:1 string:"file" int32:50 >/dev/null 2>/dev/null
}
