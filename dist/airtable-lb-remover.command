#!/bin/bash
''':'
dir=${0%/*}
if [ -d "$dir" ]; then
  cd "$dir"
fi

printf "\n\n----------     Suppresion de saut de ligne | Fichier CSV Airtable     ----------\n"
printf "Dossier de travail actuel:\n$dir"

exec python "$0" "$@"
'''

import csv
import os
import logging

logger = logging.getLogger(__name__)
handler = logging.StreamHandler()
formatter = logging.Formatter("LB Remover - %(levelname)s: [%(funcName)s]\n%(message)s \n")
handler.setFormatter(formatter)
logger.addHandler(handler)

def fileReader(filename):
    with open(filename, "r") as f:
        return f.read()

class LBRemover(object):
    def __init__(self, data, lbchar='\n', separator=';'):
        self.lbchar = lbchar
        logger.info("Caractere de saut de lignes: {} ASCII".format(ord(self.lbchar)))
        self.separator = separator
        logger.info("Caractere du delimiteur: '{}'".format(self.separator))

        self.filename = {"id": id, "data": data}
        logger.info("Fichier avec les 'ids': {}".format(self.filename["id"]))
        logger.info("Fichier avec les 'data': {}".format(self.filename["data"]))

        self.ids = []

        if os.path.isfile(self.filename["data"]):
            with open(self.filename["data"]) as csvFile:
                reader = csv.reader(csvFile, delimiter=",")
                for row in reader:
                    if unicode(row[0], 'utf-8').isnumeric():
                        self.ids.append(row[0])

            self.content = fileReader(self.filename["data"])

        logger.debug('Ids: {}'.format(self.ids))
        logger.debug('Contenu: {}'.format(self.content))

    def _detectIndex(self, content, ids):
        index = []

        for idx, id in enumerate(ids):
            str = self.lbchar + id

            try:
                start = index[idx-1]
            except:
                start = 0

            index.insert(idx, content.find(str, start)+1)

        logger.debug('Index: {}'.format(index))
        return index

    def _createCSVLines(self, content, index):
        index.insert(0, 0)
        lines = [content[start:end]
                for start, end in zip(index, index[1:]+ [len(self.content)])]

        if logger.level == "DEBUG":
            with open('lines.txt', 'w+') as file:
                for line in lines:
                    file.write(line)
                    file.write('\n\n --------------------------------------  \n\n')

        return lines;

    def _parseLines(self, content):
        occurence = 0
        lines = []

        for line in content:
            l = line[:-1]
            occurence += l.count(self.lbchar)
            lines.append(l.replace(self.lbchar, ''))


        return [lines, occurence]

    def _parseComaSeparator(self, line, separator):
        quoteCount = line.count('"')
        logger.debug("Nombre de quotes: {}".format(quoteCount))

        quoteIdx = []
        for idx in range(0, quoteCount):
            try:
                start = quoteIdx[idx-1]+1
            except:
                start = 0

            quoteIdx.insert(idx, line.find('"', start))

        logger.debug("Toutes les quotes: {}".format(quoteIdx))

        comaCount = line.count(",")
        comaIdx = []
        for idx in range(0, comaCount):
            try:
                start = comaIdx[idx-1]+1
            except:
                start = 0
            comaIdx.insert(idx, line.find(",", start))

        logger.debug("Index des virgules: {}".format(comaIdx))

        sequence = line
        for i in range(0, len(comaIdx)):
            rIdx = 0
            replaced = []
            for quoteStart, quoteEnd in zip(quoteIdx[0::2], quoteIdx[1::2]):

                replaced.insert(rIdx,comaIdx[i] in range(quoteStart, quoteEnd))
                rIdx =+ 1

            logger.debug("Replaced : {}".format(replaced))
            if True not in replaced:
                sequence = sequence[:comaIdx[i]] + self.separator + line[comaIdx[i]+1:]

        logger.debug("Nouvelle ligne: \n{}".format(sequence))
        return sequence

    def _writeNewCSVFile(self, content, filename=None):
        if filename is None:
            name, ext = os.path.splitext(self.filename["data"])
            filename = name + '_parsed' + ext

        with open(filename, 'w+') as file:
            for line in content:
                nline = self._parseComaSeparator(line + self.lbchar, self.separator)
                file.write(nline)

        print("Fichier '{}' ecrit".format(filename))

    def run(self, filename=None):
        lbcount = self.content.count(self.lbchar)
        logger.info('Nombre de SdL: {}'.format(lbcount))

        self.index = self._detectIndex(self.content, self.ids)
        logger.debug("Nombres d'index: {}".format(len(self.index)))

        self.lines = self._createCSVLines(self.content, self.index)
        logger.debug('Nombre de lignes : {}'.format(len(self.lines)))

        if len(self.lines) != len(self.ids)+1:
            logger.warning(
                "Plus de lignes ({0}) que d'identifiants ({1}): une erreur a pu survenir"
                .format(len(self.lines), len(self.ids))
            )

        [self.parsed, removed] = self._parseLines(self.lines)
        logger.debug('Nombre de lignes analysees: {0}'.format(len(self.parsed)))
        logger.info('SdL retires: {}'.format(removed))

        flbcount = lbcount - removed
        logger.info('Nombre de SdL final: {}'.format(flbcount))

        if flbcount+1 != len(self.lines):
            logger.warning(
                'Nombre de saut de lignes ({}) est different du nombre de lignes({}) : une erreur a pu survenir'
                .format(flbcount, len(self.lines))
            )

        self._writeNewCSVFile(self.parsed, filename)


if __name__ == '__main__':
    import sys
    import argparse
    import logging

    logger = logging.getLogger(__name__)

    parser = argparse.ArgumentParser(
                prog="Remover",
                usage="Remover [-h] [-d filename.csv] [-o output.csv] [-v]",
                description="Script pour retirer les sauts de lignes dans un fichier CSV",
                epilog="LB Remover - Airtable | Amaury GUILLERMIN"
    )

    parser.add_argument("-d", "--data",
        metavar="",
        default="data.csv",
        help="Chemin jusqu'au fichier CSV de donnees",
    )

    parser.add_argument("-o", "--output",
        metavar="",
        default=None,
        help="Nom du fichier de sortie"
    )

    parser.add_argument("--delimiter",
        metavar="",
        default=";",
        help="Caractere delimiteur du CSV"
    )

    parser.add_argument("--linebreak",
        metavar="",
        default="\n",
        help="Caractere de saut de lignes"
    )


    parser.add_argument('-v', '--verbose', action='count', default=0)

    args = parser.parse_args()

    if args.verbose == 0:
        logger.setLevel(logging.ERROR)
    elif args.verbose == 1:
        logger.setLevel(logging.WARNING)
    elif args.verbose == 2:
        logger.setLevel(logging.INFO)
    elif args.verbose == 3:
        logger.setLevel(logging.DEBUG)
    elif args.verbose > 3:
        logger.setLevel(logging.DEBUG)


    if len(sys.argv) <= 1:
        if args.data == 'data.csv':
            data = raw_input("\nChemin vers le fichier de donnees : \n")
            if not data:
                data = args.data
    else:
        data = args.data

    print('\n')

    remover = LBRemover(data,
                        separator=args.delimiter,
                        lbchar=args.linebreak)

    remover.run(args.output)