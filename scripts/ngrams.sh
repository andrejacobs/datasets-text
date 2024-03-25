#!/usr/bin/env bash
# Copyright (c) 2024 Andre Jacobs
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Generate ngrams from the corpora

set -eu
set -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if ! command -v ngrams >/dev/null 2>&1; then
    echo "Please install ngrams from https://github.com/andrejacobs/go-analyse"
    exit 1
fi

CORPORA_DIR=${SCRIPT_DIR}/../corpora
OUTPUT_DIR=${SCRIPT_DIR}/../ngrams

# Generate letter ngrams
function letters() {
    local LANG=$1
    local SIZE=$2
    local INPUT_DIR=$3
    local OUTPUT_DIR=$4/letters/${LANG}
    local OUTPUT_FILE="${OUTPUT_DIR}/${LANG}-letter-${SIZE}-ngrams.txt"

    if [ -f "${OUTPUT_FILE}" ]; then
        echo "Skipping '${LANG}' letter ${SIZE}-ngrams since file exists: ${OUTPUT_FILE}"
        return 0
    fi

    mkdir -p "${OUTPUT_DIR}"

    echo "Generating '${LANG}' letter ${SIZE}-ngrams to: ${OUTPUT_FILE}"
    ngrams -a "${LANG}" -l -s "${SIZE}" -verbose -progress -out "${OUTPUT_FILE}" "${INPUT_DIR}"/*.zip
}

# Generate word ngrams
function words() {
    local LANG=$1
    local SIZE=$2
    local INPUT_DIR=$3
    local OUTPUT_DIR=$4/words/${LANG}
    local OUTPUT_FILE="${OUTPUT_DIR}/${LANG}-word-${SIZE}-ngrams.txt"

    if [ -f "${OUTPUT_FILE}" ]; then
        echo "Skipping '${LANG}' word ${SIZE}-ngrams since file exists: ${OUTPUT_FILE}"
        return 0
    fi

    mkdir -p "${OUTPUT_DIR}"

    echo "Generating '${LANG}' word ${SIZE}-ngrams to: ${OUTPUT_FILE}"
    ngrams -a "${LANG}" -w -s "${SIZE}" -verbose -progress -out "${OUTPUT_FILE}" "${INPUT_DIR}"/*.zip
}

function top() {
    local SIZE=$1
    local INPUT_DIR=$2

    find "${INPUT_DIR}" -name '*.txt' -not -name 'top-*' -print0 | 
    while IFS= read -r -d '' line; do
        local TOPFILE=`dirname $line`"/top-${SIZE}-"`basename $line`

        if ! [ -f "${TOPFILE}" ]; then
            echo "Generating ${TOPFILE}"
            head -n ${SIZE} "$line" > "$TOPFILE"
        fi
    done
}

#------------------------------------------------------------------------------
# Gutenberg
#------------------------------------------------------------------------------
letters "en" 1 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"
letters "en" 2 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"
letters "en" 3 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"
letters "en" 4 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"

letters "fr" 1 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"
letters "fr" 2 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"
letters "fr" 3 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"
letters "fr" 4 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"

letters "de" 1 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"
letters "de" 2 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"
letters "de" 3 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"
letters "de" 4 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"

# Need to add italian alphabet to ngrams
# letters "it" 1 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"
# letters "it" 2 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"
# letters "it" 3 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"
# letters "it" 4 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"

words "en" 1 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"
words "en" 2 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"
words "en" 3 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"
words "en" 4 "${CORPORA_DIR}/gutenberg.org/english" "${OUTPUT_DIR}/gutenberg.org"

words "fr" 1 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"
words "fr" 2 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"
words "fr" 3 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"
words "fr" 4 "${CORPORA_DIR}/gutenberg.org/french" "${OUTPUT_DIR}/gutenberg.org"

words "de" 1 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"
words "de" 2 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"
words "de" 3 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"
words "de" 4 "${CORPORA_DIR}/gutenberg.org/german" "${OUTPUT_DIR}/gutenberg.org"

# Need to add italian alphabet to ngrams
# words "it" 1 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"
# words "it" 2 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"
# words "it" 3 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"
# words "it" 4 "${CORPORA_DIR}/gutenberg.org/italian" "${OUTPUT_DIR}/gutenberg.org"

#------------------------------------------------------------------------------
# Wortschatz, Leipzig University
#------------------------------------------------------------------------------
letters "en" 1 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
letters "en" 2 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
letters "en" 3 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
letters "en" 4 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"

letters "af" 1 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
letters "af" 2 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
letters "af" 3 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
letters "af" 4 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"

#TODO: Add japanese alphabet to ngrams

words "en" 1 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
words "en" 2 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
words "en" 3 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
words "en" 4 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/english" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"

words "af" 1 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
words "af" 2 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
words "af" 3 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
words "af" 4 "${CORPORA_DIR}/wortschatz.uni-leipzig.de/afrikaans" "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"

#TODO: Add japanese alphabet to ngrams

#------------------------------------------------------------------------------
# Top 
#------------------------------------------------------------------------------

top 1000 "${OUTPUT_DIR}/gutenberg.org"
top 1000 "${OUTPUT_DIR}/wortschatz.uni-leipzig.de"
