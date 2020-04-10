@ECHO OFF

ECHO.
ECHO --------------------------------------------------------------------------------
ECHO ----------     Suppresion de saut de ligne : Fichier CSV Airtable     ----------
ECHO --------------------------------------------------------------------------------
ECHO.

SET CWD=%cd%

ECHO Dossier de travail actuel:
ECHO %CWD%

SET FILENAME=airtable-lb-remover
SET FILEPATH=%CWD%\%FILENAME%
python %FILEPATH%

PAUSE(10)
