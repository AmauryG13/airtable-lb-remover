from airtor.logs import Logger
from airtor.core.filesystem import File
from airtor.core.parsing import CSV
from airtor.core.string import Sanitizer

class Convertor(File, CSV, Sanitizer):
    logs = Logger(__name__)

    def __init__(self, separator, delimiter, linebreak, strings):
        super(Convertor, self).__init__(separator)

    def getOriginalFileContent(self, filename):
        readable = self._isFile(filename)

        if readable:
            size = self.getContentSize(filename)
            content = self.getContent(filename, size, withHeaders=False)
            return content

        raise RuntimeError("File to parsed not found")

    def writeNewConvertedFile(self, filename, content, headers=None):
        self.writeFile(filename, content, headers)

    def sanitizeFileContent(self, content):
        for i, row in enumerate(content):
            for j, col in enumerate(row):

                string = self.sanitize(content[i][j])
                content[i][j] = string

        return content


if __name__ == '__main__':
    convertor = Convertor(',', ';', '\n', [';', '\n'])

    file = 'tests/data.csv'

    content = convertor.getOriginalFileContent(file)
    print(content[1])

    sContent = convertor.sanitizeFileContent(content[0])
    sHeaders = convertor.sanitizeFileContent([content[1]])

    convertor.writeNewConvertedFile(file, sContent, sHeaders)
