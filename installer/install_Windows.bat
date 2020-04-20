ECHO @OFF

rem Setup path
SET BaseDir=%CD%
SET SetupDir="%BaseDir%\.."

echo %SetupDir%

rem Get the python exec
FOR /f "delims=" %%i IN ('python --version') DO SET PY_VERS=%%i
echo %PY_VERS%

SET PY_V=%PY_VERS:~7,1%

echo %PY_V%

IF /I "%PY_V%" == "3" (
    SET PYTHON_EXEC="python"
) ELSE (
    SET PYTHON_EXEC="python3"
)

rem Build package
CALL cd %SetupDir%
CALL %PYTHON_EXEC% setup.py install --user

PAUSE 5
