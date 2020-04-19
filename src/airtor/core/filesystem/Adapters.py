import csv

from airtor.utils.file2stream import file2stream

class CSVAdapter(object):
    _separator = ','

    def __init__(self, delimiter):
        self.separator = delimiter

    @file2stream('w+')
    def writeCSVFile(self, filename, content, headers=None):
        writer = csv.writer(filename, delimiter=self.separator)

        if headers is not None:
            for header in headers:
                writer.writerow(header)

        for row in content:
            writer.writerow(row)

    @property
    def separator(self):
        return self._separator

    @separator.setter
    def separator(self, value):
        self._separator = value

class TextAdapter(object):
    _separator = ','

    def __init__(self, delimiter):
        self.separator = delimiter

    @file2stream('w+')
    def writeTXTFile(self, filename, content, headers=None):
        if headers is not None:
            for header in headers:
                filename.write(header)

        for row in content:
            filename.write(row)
