#!/bin/bash
case "${GITHUB_REF}" in
    refs/heads/main)
        echo "Using tag 'latest'" >&2
        echo "::set-output name=TAG::latest"
        ;;
    /refs/tags/*)
        echo "Using tag '${GITHUB_REF/refs\/tags\//}'" >&2
        echo "::set-output name=TAG::${GITHUB_REF/refs\/tags\//}"
        ;;
    *)
        echo "I don't know what to do with '${GITHUB_REF}'" >&2
        exit 1
        ;;
esac
