#!/bin/sh

filename=mushikuizan_taikai
epubcheck=/Applications/epubcheck-3.0.1/epubcheck-3.0.1.jar
kindlegen=/Applications/KindleGen_Mac_i386_v2_9/kindlegen
excludes="mimetype *.DS_Store $filename.epub $filename.mobi $filename.azk $0"

case "$1" in
    "epub")
        if [ -e $filename.epub ]; then rm -f $filename.epub; fi
        zip $filename.epub -X -0 mimetype
        zip $filename.epub -r * -x $excludes ;;
    "check")
        if [ ! -e $filename.epub ]; then $0 epub; fi
        java -jar $epubcheck $filename.epub ;;
    "mobi")
        if [ ! -e $filename.epub ]; then $0 epub; fi
        $kindlegen -locale ja $filename.epub ;;
    "clean") rm -f *.epub *.mobi *.azk ;;
esac

exit 0
