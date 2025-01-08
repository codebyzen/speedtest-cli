#!/bin/bash

echo "">log.log
url1="https://cachev2-mar-44.cdn.yandex.net/internetometr.download.cdn.yandex.net/bigfile.png?1736364037429&lid=273"
url2="https://www.elitetrack.com/wp-content/uploads/2014/10/bigstock-The-Big-Picture-Concept-36887548.jpg"
wget --report-speed=bits ${url2} -O file.big -o log.log
SPEED="$(grep -i "file.big' saved" log.log|sed -n "s/^.*(\s*\(.*\)).*$/\1/p")"
DIGITS="$(echo $SPEED|sed -n "s/\(\S*\).*/\1/p")"
REALSPEED="$(echo "2 k ${DIGITS} 8 / p"|dc)"

ISLESSZERO="$(echo $REALSPEED|cut -c1-1)"

if [ "$ISLESSZERO" = "." ]; then
    echo 0$REALSPEED megabytes/second
else
    echo $REALSPEED megabytes/second
fi
unlink file.big
unlink log.log
