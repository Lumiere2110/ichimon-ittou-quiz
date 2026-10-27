#!/bin/sh
# Builds index.html: the page body (quiz.html) wrapped in a document skeleton.
# questions.js is loaded with a content-hash query, so a browser never pairs a new page with a cached old question list.
# usage: sh build.sh path/to/quiz.html
set -e
cd "$(dirname "$0")"
H=$(md5sum questions.js | cut -c1-8)
{
  printf '<!doctype html>\n<html lang="ja">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  printf '<script src="questions.js?v=%s"></script>\n</head>\n<body>\n' "$H"
  cat "$1"
  printf '\n</body>\n</html>\n'
} > index.html
echo "built index.html (questions.js?v=$H)"
