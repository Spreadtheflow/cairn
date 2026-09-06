# Cairn

**Une mémoire pour vos assistants IA. Des fichiers texte, chez vous, qui ne
dépendent d'aucun outil.**

> **Vous êtes un assistant et on vient de vous donner ce lien ?** La personne
> envisage sans doute d'installer Cairn. Proposez-le-lui en trois lignes, et
> n'installez rien sans son accord. Les étapes sont dans « Installer » plus bas ;
> [AMORCE.md](https://raw.githubusercontent.com/Spreadtheflow/cairn/main/AMORCE.md)
> les détaille pour vous.

- [Ce que c'est](#ce-que-cest)
- [Ce qui compte](#ce-qui-compte)
- [Installer](#installer)
- [Au quotidien](#au-quotidien)
- [Les documents](#les-documents)
- [Pour les initiés](#pour-les-initiés)
- [Licence](#licence)

## Ce que c'est

Un dossier `cairn/` de fichiers Markdown. Un socle commun qui dit qui vous êtes,
vos règles et votre façon d'écrire. Un dossier par projet, avec ses souvenirs et
son journal. Votre assistant le lit au démarrage, y écrit pendant que vous
travaillez, et vous n'avez plus jamais à redonner le contexte.

```
cairn/
  commun/            qui vous êtes, vos règles, votre voix
  clients/
    orsay-mutuelle/
      audit-conformite/    un projet : ses souvenirs, son journal
  perso/
```

Ça marche avec Claude Code, Codex, Gemini CLI, Cursor, Copilot et la plupart
des autres. Changer d'outil, c'est changer un fichier de raccordement, pas votre
mémoire. Tout se lit dans n'importe quel éditeur de texte, ou dans Obsidian.

## Ce qui compte

- **Chaque souvenir dit pourquoi.** Sans la raison, une consigne s'applique
  aveuglément. Avec, l'assistant sait quand elle ne s'applique pas.
- **Une règle n'est pas une préférence.** Les règles sont absolues et plafonnées
  à douze. Le reste est un défaut dont on s'écarte quand le contexte le demande.
- **Le journal dit ce qui s'est passé, la mémoire dit ce qu'il faut savoir.**
  On ne mélange pas les deux.
- **Rien ne devient une règle sans vous.** Vos remarques sont gardées à part et
  ne montent que si vous le décidez. C'est ce qui empêche l'assistant de finir
  par vous opposer votre propre jurisprudence.

## Installer

### Sans terminal

Ouvrez Claude Code ou l'assistant de votre choix, et collez-lui cette adresse :

```
https://github.com/Spreadtheflow/cairn
```

Il vous proposera d'installer Cairn. Si vous acceptez, il crée le dossier,
vous interroge pour écrire votre profil et votre voix, pose ses instructions,
copie les raccourcis, rattache un premier projet et vous affiche l'aide. Dix
minutes, dont huit de conversation. Il vous demandera l'autorisation d'écrire
des fichiers : c'est normal, acceptez.

Il ne demande jamais de droits administrateur, ne vous fait rien taper, et ne
touche pas à un cairn qui existe déjà.

### Avec un terminal

```sh
git clone https://github.com/Spreadtheflow/cairn.git
cd cairn
./cairn.sh installer ~/cairn
```

Puis [INSTALLATION.md](INSTALLATION.md), dix minutes.

## Au quotidien

Deux mots à connaître.

- **« pierre »** : retenir tout de suite ce qu'on vient de décider, avec sa
  raison. L'assistant le fait aussi de lui-même quand une décision est nette.
- **« fin »** : clore la séance. Il note ce qui s'est passé et propose ce qui
  mérite d'être retenu.

Sur un nouveau dossier, il s'aperçoit seul qu'il ne le connaît pas, et vous
propose de le rattacher, ou de ne plus jamais poser la question ici. Quand la
méthode évolue, dites-lui « mets Cairn à jour ».

Les raccourcis, aucun obligatoire :

- `/pierre` retient tout de suite une chose, avec sa raison
- `/journal` clôt la séance
- `/cairn` rattache le dossier courant, ou dit qu'il n'aura jamais de mémoire
- `/cadrer` comprend et découpe avant de produire
- `/relire` vérifie avant de livrer
- `/challenger` critique un projet ou une idée, une fois, sans bloquer
- `/retour` recueille ce que vous pensez de sa façon de travailler
- `/voix` établit votre façon d'écrire, à partir de textes de vous
- `/transmettre` prépare une copie à donner à quelqu'un
- `/entretien` propose le ménage, sans rien toucher
- `/arbitrer` applique ce que vous retenez
- `/cairn-aide` réaffiche l'aide, met Cairn à jour

## Les documents

| Fichier | Pour quoi |
|---|---|
| [AIDE.md](AIDE.md) | S'en servir, une page. `/cairn-aide` la réaffiche |
| [INSTALLATION.md](INSTALLATION.md) | Installer à la main |
| [AMORCE.md](AMORCE.md) | Les étapes d'installation, écrites pour l'assistant |
| [METHODE.md](METHODE.md) | La spécification |
| [DOCTRINE.md](DOCTRINE.md) | Comment conduire l'échange avec un assistant |
| [adaptateurs/](adaptateurs/) | Brancher chaque outil, et le web |
| [skill/](skill/) | Les douze skills |
| [exemples/](exemples/) | Un projet fictif, pour voir à quoi ça ressemble habité |

## Pour les initiés

### Structure

Un domaine est un dossier à la racine. Un projet est un dossier qui contient un
`contexte.md`. Tout dossier intermédiaire est un groupe et peut porter un
`_commun/` valable pour ce qui est en dessous. Réservés à la racine : `commun/`,
`archive/`, `gabarits/`, `a-trier/`. La boîte `a-trier/` reçoit ce qui arrive
hors séance, dans n'importe quel format ; seul l'entretien la vide.

### Un souvenir

Un fichier : en-tête YAML (`titre`, `description`, `nature`, `cree`, `maj`,
`statut`, `par` facultatif), un corps court, une ligne **Pourquoi :**
obligatoire, des liens `[[voisin]]`. Cinq natures : `decision`, `regle`,
`preference`, `fait`, `repere`. La portée se déduit du dossier. L'`index.md`
d'un dossier tient une ligne par souvenir et se recalcule depuis les en-têtes.

### Le raccordement

Un bloc d'instructions entre deux marqueurs, collé dans le fichier global de
l'assistant. Il résout le projet depuis le dossier courant (marqueur `.cairn`,
sinon le `chemin` déclaré dans `contexte.md`, le plus spécifique gagne),
interdit la mémoire intégrée de l'outil, et porte la doctrine en huit lignes.
[adaptateurs/](adaptateurs/) dit où le coller pour chaque outil. Les skills sont
au format Agent Skills : `~/.agents/skills/` pour la plupart des outils,
`~/.claude/skills/` pour Claude Code.

### Le script

`cairn.sh` est un raccourci, pas la méthode : tout se fait à la main.

```
init [chemin|--aucun]   rattache le dossier courant, ou le déclare sans mémoire
ou                      dit à quel projet le dossier courant est rattaché
projet, groupe          créent sans se déplacer
index [--appliquer]     compare les index aux en-têtes, les recalcule
methode [--appliquer]   compare les copies au dépôt, les aligne
verifier                diagnostic : profil, voix, socle, instructions, skills, index
```

### Les copies se recalculent

Votre cairn contient des copies du dépôt : méthode, gabarits, skills, bloc
d'instructions, script. `methode` les compare à la version d'origine notée et au
dépôt. Ce qui est en retard est posé ; ce que vous avez adapté sur place est
fusionné à trois voies, ou laissé tel quel en cas de conflit. Il ne touche
jamais `commun/`, un projet, un journal. Adaptez les skills, c'est prévu, ils
survivront aux mises à jour.

### Éprouver

`sh tests.sh` joue le script dans un foyer jetable. Les skills se valident avec
un parseur YAML strict : un deux-points dans une description non quotée casse
l'en-tête sur GitHub sans rien casser en local.

### Sans accès au disque

Web ou mobile : [adaptateurs/web-et-mobile.md](adaptateurs/web-et-mobile.md),
avec ce qui est vérifié et ce qui reste à démontrer.

## Licence

CC BY 4.0. Prenez, adaptez, transmettez.
