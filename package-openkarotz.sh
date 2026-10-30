#!/bin/sh
echo "Welcome to the installation of OpenKarotz (as package of Free Rabbits OS)."
echo "Please wait while OpenKarotz is installed..."
dbus-send --system --dest=com.mindscape.karotz.Led /com/mindscape/karotz/Led com.mindscape.karotz.KarotzInterface.pulse string:"" string:"660099" string:"000000" int32:400 int32:-1 >/dev/null 2>/dev/null

# start download the files we need
echo "Downloading package openkarotz as ZIP file, please wait..."
if [ -f /tmp/package-openkarotz.zip ]; then
    echo "Package déjà présent dans /tmp, téléchargement ignoré."
else
    echo "Downloading package openkarotz as ZIP file, please wait..."
    wget -O /tmp/package-openkarotz.zip http://www.freerabbits.nl/downloads/karotz/package-openkarotz.zip
    echo "End downloading, installation will start..."
fi

echo "End downloading, installation will start..."
# end download the files we need

# Start extract package file
echo "Checking file"
md5sum /tmp/package-openkarotz.zip
echo "Extracting the packagefile, please wait..."
/bin/unzip -oq /tmp/package-openkarotz.zip -d /tmp
# End extract package file

# Start Install OpenKarotz
echo "Installing /usr/openkarotz, please wait..."
[ ! -d "/usr/openkarotz" ] && mkdir /usr/openkarotz
/bin/unzip -oq /tmp/openkarotzusr.zip -d /usr/openkarotz
# End Install OpenKarotz

# Start Install WWW
echo "Installing /usr/www including /usr/www/cgi-bin, please wait..."
[ ! -d "/usr/www" ] && mkdir /usr/www
/bin/unzip -oq /tmp/openkarotzwww.zip -d /usr/www
chmod -R 755 /usr/www/cgi-bin
cp -f /usr/www/cgi-bin/dbus_events /usr/scripts/dbus_watcher
ln -s /usr/openkarotz/Snapshots /usr/www/snapshots
ln -s /usr/openkarotz/Tmp /usr/www/ttscache
# End Install WWW

dbus-send --system --dest=com.mindscape.karotz.Led /com/mindscape/karotz/Led com.mindscape.karotz.KarotzInterface.pulse string:"" string:"00FF00" string:"000000" int32:700 int32:-1 >/dev/null 2>/dev/null
echo "End installing OpenKarotz (as package of Free Rabbits OS)."
echo "Go to the homepage of your Karotz and press F5 (refresh the page) to start OpenKarotz."
echo "Done!"