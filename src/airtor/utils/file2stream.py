import io

def file2stream(mode='r'):
    def decorated(func):
        def convertFilename2Stream(self, *args, **kwargs):
            largs = list(args)

            f = io.open(largs[0], mode, encoding='utf-8')

            largs[0] = f
            args = tuple(largs)

            output = func(self, *args, **kwargs)

            f.close()
            return output
        return convertFilename2Stream
    return decorated
