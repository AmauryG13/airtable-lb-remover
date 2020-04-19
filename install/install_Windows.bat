SET BaseDir=%0
SET SetupDir=%BaseDir%\..

CALL cd %SetupDir%
CALL python setup.py install --user
