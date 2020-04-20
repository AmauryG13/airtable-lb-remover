#! /bin/sh

EXEC='airtable-convertor'
MODULE='airtor.cli'

# Select python exec
PY_VERS=$(python --version 2>&1)

if [ -n "${PY_VERS}" ]; then
  PY_V="${PY_VERS:7:1}"
fi

if [ "${PY_V}" == "3" ]; then
  PYTHON_EXEC="python"
else
  PYTHON_EXEC="python3"
fi

if [ which ${EXEC} ]; then
  ${EXEC}
else
  ${PYTHON_EXEC} -m ${MODULE}
fi
