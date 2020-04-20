#! /usr/bin/python3
import sys, os

from airtor.cli import Cli

command = False

print("--------------------     Convertisseur | Airtable     --------------------\n")
print("Dossier de travail actuel:\n{}\n".format(os.getcwd()))

cli = Cli()
cli.parse()

if len(sys.argv) <= 1:
    command = True

cli.display(command)

success = cli.run()
cli.exit(success)
