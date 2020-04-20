#! /bin/sh
exec=airtable-convertor
module=airtor.cli

if which $exec ; then
  $exec
else
  python3 -m $module
fi
