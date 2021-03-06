@echo off

rem Set executable name
SET EXEC=airtable-convertor
SET MODULE=airtor.cli

rem Get the python exec
FOR /f "delims=" %%i IN ('python --version') DO SET PY_VERS=%%i
SET PY_V=%PY_VERS:~7,1%

IF /I "%PY_V%" == "3" (
    SET PYTHON_EXEC="python"
) ELSE (
    SET PYTHON_EXEC="python3"
)

CALL %PYTHON_EXEC% -m %MODULE% %*

PAUSE 5
