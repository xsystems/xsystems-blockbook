#!/bin/sh

if [ -z "${VERSION}" ]; then
  echo "The VERSION environment variable is NOT set, BUT is required."
  exit
fi

COMMIT=${COMMIT:-`git rev-parse HEAD`}

git tag --annotate --message "Release ${VERSION}" ${VERSION} ${COMMIT}
git push origin ${VERSION}
