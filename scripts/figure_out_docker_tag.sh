#!/bin/bash

case "${GITHUB_REF}" in
    /refs/tags/)
        echo "::set-output name=TAG::${GITHUB_REF/refs\/tags\//}"
        ;;
    *)
        echo "::set-output name=TAG::${GITHUB_REF}"
        ;;
done
