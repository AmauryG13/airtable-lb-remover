# Airtable Line Break Remover

Script python pour retier les sauts de lignes dans les commentaires des fichiers CSV exportés depuis Airtable

Le script est optimisé pour une exécution :
* soit avec python : `$ python airtable-lb-remover`

* soit avec bash (sous __Unix__) : `$ ./airtable-lb-remover`

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

* `[-i / -id] filename.csv` : chemin vers le fichier d'identifiants de colonnes

* `[-o / -output] filename.csv` : nom du fichier de sortie

Par exemple :
```
$ ./airtable-lb-remover -d data.csv -i ids.csv -o output.csv
```

### Exécutable
Le fichier peut également en exécuter (sur un système _Unix_) en clickant dessus.

Ce processus ouvrira une fenetre en demandant de renseigner 2 champs :
* Le chemin vers le fichier des identifiants de colonnes
* Le chemin vers le fichier de données

Par défaut, le script retournera un fichier csv corrigé avec pour nom : `${fichierdonnes}_parsed.csv`

#### Cheers
Coded with :heartpulse:
