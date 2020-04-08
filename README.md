# Airtable Line Break Remover

Script python pour retier les sauts de lignes dans les commentaires des fichiers CSV exportés depuis Airtable

Le script est optimisé pour une exécution :
* soit avec python : `$ python airtable-lb-remover`

* soit avec bash (sous __Unix__) : `$ ./airtable-lb-remover`

Les fichiers executables, à télécharger, sont situés dans le dossier `__dist__`.

## Usage

Avant tout utilisation, il est nécessaire de rentrer le script exécutable :

```
$ chmod a+x airtable-lb-remover
```

Il est possible également de choisir l'exécuteur de script dans l'entete du fichier en renseignant le chemin de son exécutable préféré :

```
#!/bin/bash

```
Par défaut, l'executeur est bash.

### Ligne de commande

Le script analyse les arguements en entrée.

Les 3 arguments utilisables, dans la version actuelle, sont :

* `[-d / -data] filename.csv` : chemin vers le fichier de données

* `[-o / -output] filename.csv` : nom du fichier de sortie

* `[-v ] ` : affichage des informations de debuggage

Par exemple :
```
$ ./airtable-lb-remover -d data.csv -o output.csv
```

### Exécutable
Le fichier peut également en exécuter (sur un système _Unix_) en clickant dessus.

Ce processus ouvrira une fenetre en demandant de renseigner 1 champs :
* Le chemin vers le fichier de données

Par défaut, le script retournera un fichier csv corrigé avec pour nom : `${fichierdonnes}_parsed.csv`

### Exécutable sous __Windows__
Pour le cas particulier de __Windows__, il faut avoir la version de python _2.7_ installée sur la machine et que l'exécutable soit renseigné dans le `%PATH%` de windows.

L'exécutable est en 2 parties :
* le script python `airtable-lb-remover`
* le script batch `airtable-lb-remover_dos.bat`

Il est fortement recommandé de placer les deux fichers dans le meme dossier.

Ce proccesus ouvrira une fenetre en demandant de renseigner 2 champs:
* Le chemin vers le fichier exécutable python : `airtable-lb-remover`
* Le chemin vers le fichier de données

#### Cheers
Coded with :heartpulse:
