#!/bin/sh

OUTPUT_NAME=${1//.pdf/-c.pdf}
echo $VAR1
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$OUTPUT_NAME $1
