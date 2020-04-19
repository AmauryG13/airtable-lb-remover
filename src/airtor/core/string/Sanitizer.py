class Sanitizer(object):
    _sanitizedStrings = [';', '\n']

    def __init__(self, strings):
        self.sanitizedStrings = strings

    def sanitize(self, value):
        for string in self.sanitizedStrings:
            value = value.replace(string, '')

        return value

    @property
    def sanitizedStrings(self):
        return self._sanitizedStrings

    @sanitizedStrings.setter
    def sanitizedStrings(self, value):
        if not isinstance(value, list):
            value = list(value)

        self._sanitizedStrings = value

if __name__ == '__main__':
    s = Sanitizer([';', '\n'])

    str = s.sanitize("Hello ; world \n")
    print(str)
