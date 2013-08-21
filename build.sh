#!/bin/sh

srcdir=src
filename=mushikuizan_taikai
epubcheck=/Applications/epubcheck-3.0.1/epubcheck-3.0.1.jar
kindlegen=/Applications/KindleGen_Mac_i386_v2_9/kindlegen

case "$1" in
    "epub")
        if [ -e $filename.epub ]; then rm -f $filename.epub; fi
        pushd $srcdir && \
            zip ../$filename.epub -X -0 mimetype && \
            zip ../$filename.epub -r * -x mimetype *.DS_Store && \
            popd ;;
    "check")
        if [ ! -e $filename.epub ]; then $0 epub; fi
        java -jar $epubcheck $filename.epub ;;
    "mobi")
        if [ ! -e $filename.epub ]; then $0 epub; fi
        $kindlegen -locale ja $filename.epub ;;
    "clean") rm -f *.epub *.mobi *.azk ;;
    *) echo "Usage: $0 [epub|check|mobi|clean]" ;;
esac

exit 0
