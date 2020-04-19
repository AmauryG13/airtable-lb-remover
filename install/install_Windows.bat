SET BaseDir=%CD%
SET SetupDir=%BaseDir%\..

CALL cd %SetupDir%
CALL python3 setup.py install
