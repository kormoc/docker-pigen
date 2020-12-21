#!/bin/bash

case "${GITHUB_REF}" in
    /refs/tags/*)
        echo "::set-output name=TAG::${GITHUB_REF/refs\/tags\//}"
        ;;
    refs/heads/*)
        echo "::set-output name=TAG::${GITHUB_REF/refs\/heads\//}"
        ;;
    *)
        echo "::set-output name=TAG::${GITHUB_REF}"
        ;;
esac
