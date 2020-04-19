import os

from airtor.core.filesystem.Writer import Writer

class File(Writer):
    def __init__(self, delimiter):
        super(File, self).__init__(delimiter)

    def _isFile(self, filename):
        return os.path.isfile(filename)

if __name__ == '__main__':
    handler = File()
