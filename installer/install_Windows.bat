rem Setup path
SET BaseDir=%CD%
SET SetupDir=%BaseDir%\..

rem Get the python exec
FOR /f %%i IN ('python --version') DO SET PY_VERS=%%i
SET PY_V=%PY_VERS:~7,1%

IF %PY_V% == "3" (
    SET PYTHON_EXEC="python"
) ELSE (
    SET PYTHON_EXEC="python3"
)

rem Build package
CALL cd %SetupDir%
CALL %PYTHON_EXEC% setup.py install
