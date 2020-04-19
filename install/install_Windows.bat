SET BaseDir=%CD%
SET SetupDir=%BaseDir%\..

CALL cd %SetupDir%
CALL python setup.py install --user
