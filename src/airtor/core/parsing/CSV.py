import csv

from airtor.logs import Logger
from airtor.utils.file2stream import file2stream

class CSV(object):
    logs = Logger(__name__)
    _delimiter = ','
    _linebreak = '\n'

    def __init__(self, delimiter, linebreak):
        super(CSV, self).__init__()
        self.delimiter = delimiter
        self.linebreak = linebreak

    def _csvify(self, fID):
        reader = csv.reader(fID, delimiter=self.delimiter)
        return reader

    @file2stream()
    def getContentSize(self, filename):
        reader = self._csvify(filename)
        contentSize = {'row': 0, 'column': None}

        for i, row in enumerate(reader):
            contentSize['row'] += 1

            if i == 0:
                contentSize['column'] = len(row)
            else:
                if contentSize['column'] == len(row):
                    contentSize['column'] = len(row)
                else:
                    self.logs.info(
                        'Line = {} | Actual size : {} vs registed : {}'
                        .format(i, len(row), contentSize["column"])
                    )
                    self.logs.warning("Error while parsing")


        self.logs.info(contentSize)
        return contentSize

    @file2stream()
    def getContent(self, filename, size, withHeaders=True):
        reader = self._csvify(filename)

        content = [
            [ '' for y in range(size["column"]) ]
            for x in range(size["row"])
        ]

        for i, row in enumerate(reader):
            for j, col in enumerate(row):
                content[i][j] = col

        if not withHeaders:
            return [content[1:][:], content[0][:]]

        return [content, None]

    @property
    def delimiter(self):
        return self._delimiter

    @delimiter.setter
    def delimiter(self, value):
        self._delimiter = value

    @property
    def linebreak(self):
        return self._linebreak

    @linebreak.setter
    def linebreak(self, value):
        self._linebreak = value

if __name__ == "__main__":
    import os

    filepath = os.path.join(os.getcwd(), 'tests/data.csv')
    fid = open(filepath, 'r')

    csvParser = CSV(',', '\n')
    size = csvParser.getContentSize(filepath)
    [content, headers] = csvParser.getContent(filepath, size, withHeaders=False)

    print(content[1][:])
    print(headers)
