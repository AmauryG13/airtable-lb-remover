@ECHO OFF

ECHO.
ECHO.
ECHO "----------     Suppresion de saut de ligne | Fichier CSV Airtable     ----------"
ECHO.

SET CWD="%cd%"

ECHO "Dossier de travail actuel:"
ECHO %CWD%

ECHO.
ECHO "Chemin jusqu'au fichier exécutable (defaut: %CWD%)"

SET FILENAME='airtable-lb-remover'
SET /P EXEC_PATH=

IF "%EXEC_PATH" == "" (
  SET FILEPATH=%CWD%\%FILENAME%
) else (
  SET FILEPATH=%CWD%\%EXEC_PATH%\%FILENAME%
)

CALL "python %FILEPATH"
