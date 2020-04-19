import logging

class Logger(object):
    _level = logging.DEBUG
    _msg = "{File} - %(levelname)s: [%(funcName)s]\n%(message)s \n"

    def __init__(self, file):
        self.trace = file

        self.logger = logging.getLogger(__package__)
        self.handler = logging.StreamHandler()
        self.formatter = logging.Formatter(self.msg)
        self.handler.setFormatter(self.formatter)
        self.logger.addHandler(self.handler)

    def debug(self, msg):
        self.logger.debug(msg)

    def info(self, msg):
        self.logger.info(msg)

    def warning(self, msg):
        self.logger.warning(msg)

    def error(self, msg):
        self.logger.error(msg)

    def critical(self, msg):
        self.logger.critical(msg)

    @property
    def msg(self):
        return self._msg.replace('{File}', self.trace)

    @property
    def level(self):
        return self._level

    @level.setter
    def loglevel(self, level):
        self._level = level
        self.logger.setLevel(level)



if __name__ == '__main__':
    log = Logger('Test')
