#! /bin/bash

# Select python exec
PY_VERS=$(python --version 2>&1)

if [ -n "$PY_VERS" ]; then
  PY_V=${PY_VERS:7:1}
fi

if [ ${PY_V} == "3" ]; then
  PYTHON_EXEC="python"
else
  PYTHON_EXEC="python3"
fi

cd "$(pwd)/.."

# Build python package
if [ -f ./setup.py ]; then
  ${PYTHON_EXEC} setup.py install --user
fi
