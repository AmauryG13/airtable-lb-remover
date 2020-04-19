#! /bin/sh

dir=${0%/*}
if [ -d "$dir" ]; then
  cd "$dir/.."
fi

# Build python package
sudo python3 setup.py install
