#!/bin/bash

usage() {
    echo "Usage: ${0} <bib file>"
    echo "  This script is a work around to correct bibliographies produced by Zotero:"
    echo "  Zotero escapes special characters in URL sequences for bib items, which is"
    echo "  unnecessary. This script tries to remove '\_' and '\&' from the given bib file."
}

fix() {
    file=${1}
    tmp=$(mktemp)


    awk '{
        if (/\s*url\s*=/) {
            gsub(/\\_/, "_");
            gsub(/\\&/, "\\&")
        }
        print $0
    }' ${file} > ${tmp}

    if [ $? -eq 0 ]; then
        mv ${tmp} ${file}
        exit 0
    else
        exit 2
    fi
}

if [ $# -eq 0 ]; then
    usage
    exit 0
elif [ -f ${1} ]; then
    fix ${1}
else
    usage
    exit 1
fi
