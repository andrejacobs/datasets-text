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

# Package up the generated ngrams

set -eu
set -o pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

INPUT_DIR=${SCRIPT_DIR}/../ngrams
OUTPUT_DIR=${SCRIPT_DIR}/../packaged/ngrams

mkdir -p "${OUTPUT_DIR}"

find "${INPUT_DIR}" -name '*.txt' -print0 | 
while IFS= read -r -d '' line; do
    LANG=$(basename "$(cd "$(dirname "$line")" && pwd)")
    LORW=$(basename "$(cd "$(dirname "$line")/../" && pwd)")
    CORPUS=$(basename "$(cd "$(dirname "$line")/../../" && pwd)")

    ZIP_DIR="${OUTPUT_DIR}/${CORPUS}/${LORW}/${LANG}"
    ZIPFILE="${ZIP_DIR}/$(basename $line).zip"

    if ! [ -f "${ZIPFILE}" ]; then
        mkdir -p "${ZIP_DIR}"
        echo "Zipping ${ZIPFILE}"
        cd "$(dirname "$line")"
        zip "${ZIPFILE}" "$(basename "$line")"
    fi
done
