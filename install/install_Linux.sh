#! /usr/bin/sh

dir=${0%/*}
if [ -d "$dir" ]; then
  cd "$dir/.."
fi

# Build python package
python setup.py install --user
