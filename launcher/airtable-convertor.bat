@echo off

SET EXEC=airtable-convertor
SET MODULE=airtor.cli

CALL %EXEC% || GOTO:python_module

PAUSE 5
GOTO:EOF

:python_module
CALL python3 -m %MODULE%
