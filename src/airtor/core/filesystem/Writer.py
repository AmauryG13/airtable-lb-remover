import os

from airtor.logs import Logger
from airtor.core.filesystem.Adapters import CSVAdapter, TextAdapter

class Writer(CSVAdapter, TextAdapter):
    logs = Logger(__name__)
    writerPrefix = 'write'
    writerSuffix = 'File'

    def __init__(self, delimiter):
        super(Writer, self).__init__(delimiter)

    def writeFile(self, filename, content, headers=None):
        [name, ext] = self._parseFilename(filename)

        nfilename = name + '_converted' + ext
        writer = getattr(self, self._getWriter(ext))(nfilename, content, headers)

    def _parseFilename(self, filename):
        name, ext = os.path.splitext(filename)
        return [name, ext]

    def _getWriter(self, ext):
        return self.writerPrefix + ext[1:].upper() + self.writerSuffix

if __name__ == '__main__':
    writer = Writer()
