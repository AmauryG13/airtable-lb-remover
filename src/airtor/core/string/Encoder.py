import sys

class Encoder(object):
    def __init__(self):
        pass

    def encode(self, value, encoder="utf-8"):
        if sys.version[0] == "2":
            return unicode(value, encoder)
        elif sys.version[0] == "3":
            return value.encode(encoder, 'ignore')
        else:
            raise Exception

    def decode(self, value, encoder="utf-8"):
        return value.decode(encoder)

    def stringify(self, value):
        return str(value)

if __name__ == '__main__':
    encoder = Encoder()

    string = encoder.encode('Élement')
    print(string)

    dec = encoder.decode(string, 'latin')
    print(dec)

    nString = encoder.stringify(string)
    print(nString)
