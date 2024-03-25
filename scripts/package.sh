#!/usr/bin/env bash
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
