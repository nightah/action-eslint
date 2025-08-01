#!/bin/bash
# Expected to run from the root repository.
set -eux
CWD=$(pwd)

# Get the installed ESLint major version
ESLINT_VERSION=$(npx eslint -v | tr -d 'v')        # e.g. 8.57.1 or 9.34.0
ESLINT_MAJOR=$(echo "${ESLINT_VERSION}" | cut -d. -f1)

# Choose config based on version
if [ "$ESLINT_MAJOR" -ge 9 ]; then
  CONFIG_FILE=".eslintrc.v9.js"
  EXPECTED="result.v9.ok"
else
  CONFIG_FILE=".eslintrc.cjs"
  EXPECTED="result.ok"
fi

# Run ESLint with selected config
npx eslint ./testdata/*.js -c "${CONFIG_FILE}" -f ./eslint-formatter-rdjson/index.js \
  | jq . \
  | sed -e "s!${CWD}/!!g" \
  > eslint-formatter-rdjson/testdata/result.out

# Compare results
diff -u eslint-formatter-rdjson/testdata/${EXPECTED} eslint-formatter-rdjson/testdata/result.out
