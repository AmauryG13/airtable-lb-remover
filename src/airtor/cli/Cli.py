import argparse

from airtor import __shortname__, __author__, Convertor

class Cli(object):
    _usage = "{Prog} [-h] [-d filename.csv] [-o output.csv] [-v]"
    _description = "Script pour les fichier CSV Airtable"
    _epilog = "{Prog} - Airtable"

    def __init__(self):
        self.parser = argparse.ArgumentParser(
            prog=__shortname__,
            usage=self.usage,
            description=self.description,
            epilog=self.epilog
        )

        self.arguments()

    def arguments(self):
        self.parser.add_argument("-d", "--data",
            metavar="",
            default="data.csv",
            help="Chemin jusqu'au fichier CSV de donnees",
        )

        self.parser.add_argument("-o", "--output",
            metavar="",
            default=None,
            help="Nom du fichier de sortie"
        )

        self.parser.add_argument("--delimiter",
            metavar="",
            default=";",
            help="Caractere delimiteur du CSV"
        )

        self.parser.add_argument("--linebreak",
            metavar="",
            default="\n",
            help="Caractere de saut de lignes"
        )

    def parse(self):
        self.args = self.parser.parse_args()

    def display(self, command):
        if command:
            data = input("\nChemin vers le fichier de donnees : \n")
            self.args.data = data

    def run(self):
        convertor = Convertor(separator=',',
            delimiter=self.args.delimiter,
            linebreak=self.args.linebreak,
            strings=[';', '\n']
        )

        content = convertor.getOriginalFileContent(self.args.data)

        sContent = convertor.sanitizeFileContent(content[0])
        sHeaders = convertor.sanitizeFileContent([content[1]])

        convertor.writeNewConvertedFile(self.args.data, sContent, sHeaders)

        return True

    def exit(self, success):
        if success:
            print("\nFichier écrit avec succes")
            return 0

        raise RuntimeError("Error durant le process")

    @property
    def usage(self):
        return self._usage.replace("{Prog}", __shortname__)

    @property
    def description(self):
        return self._description

    @property
    def epilog(self):
        return "{} | {}".format(
            self._epilog.replace("{Prog}", __shortname__),
            __author__
        )
