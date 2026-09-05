# Cairn

**Une méthode simple pour donner de la mémoire à vos assistants IA, sans dépendre
d'aucun d'entre eux.**

Un cairn, c'est ce tas de pierres que les marcheurs élèvent au fil du passage :
chacun ajoute la sienne, l'édifice grossit lentement, et il finit par baliser le
chemin pour ceux qui viennent après. C'est exactement ce qu'on cherche à faire
ici.

## Le problème

Vous travaillez avec une IA. Elle est utile, mais elle ne se souvient de rien
d'une session à l'autre. Alors vous redonnez le contexte, encore. Vous répétez
vos préférences, encore. Et quand vous changez d'outil, de modèle ou
d'ordinateur, tout est à refaire.

Certains outils proposent bien une mémoire, mais elle vit dans un dossier caché
qui leur appartient. Vous ne pouvez ni la lire confortablement, ni la
transmettre, ni l'emporter ailleurs.

## Ce que Cairn propose

Un dossier. Des fichiers texte. C'est tout.

```
cairn/
  commun/               ce qui vaut pour tout ce que vous faites
  clients/
    orsay-mutuelle/     un client
      audit-conformite/   un projet
      refonte-intranet/   un autre projet du même client
  perso/
    ma-maison/
```

Vous rangez comme vous voulez, aussi profond que nécessaire. Un dossier qui
contient une fiche `contexte.md` est un projet, les autres ne servent qu'à
ranger.

Chaque projet a ses souvenirs, son journal et sa fiche d'identité, en Markdown
ordinaire. Vous les ouvrez avec n'importe quel éditeur de texte, ou dans Obsidian
si vous voulez une vraie interface de lecture. Vos assistants s'y branchent par
un petit fichier de raccordement, et si vous en changez demain, vous changez le
raccordement, pas votre organisation.

## Les quatre idées

**Séparer ce qui vaut partout de ce qui vaut ici.** Votre façon d'écrire les
dates ne concerne pas un projet en particulier : elle monte dans le socle commun
et s'applique à tout. Le mot de passe wifi de votre client, non.

**Séparer ce qu'il faut savoir de ce qui s'est passé.** La mémoire répond à
« que dois-je savoir », le journal à « que s'est-il passé ». Mélanger les deux
est l'erreur la plus commune, et c'est celle qui finit par tout engorger.

**Toujours écrire le pourquoi.** « Fais X » ne peut être appliqué
qu'aveuglément. « Fais X parce que Y » permet de reconnaître les cas où Y ne
tient pas. C'est toute la différence entre une mémoire et un règlement.

**Empêcher la mémoire de devenir un carcan.** C'est le danger réel de ces
systèmes : à force d'accumuler, chaque préférence devient une loi, et
l'assistant finit par vous opposer votre propre jurisprudence à chaque phrase.
Cairn plafonne le nombre de règles, distingue les règles absolues des simples
habitudes, et propose régulièrement d'en retirer.

## Vous décidez de ce qui est retenu

À la création d'un projet, quatre questions, une seule fois. Notamment : est-ce
qu'on retient quelque chose ici, et où pourra finir ce qui sera écrit.

Si le projet est privé, on écrit en clair, noms compris. C'est le but : ne plus
jamais redonner le contexte. Si en revanche ce que vous écrivez est destiné à
être publié ou remis à un tiers, on anonymise au moment d'écrire.

À savoir, dit franchement : le contenu d'un cairn est stocké **en clair** sur
votre disque, versionné si vous utilisez git, et synchronisé sur vos autres
appareils si vous mettez ça en place. Cairn vous informe, il ne vous bloque pas.
Une seule chose n'est jamais négociable : on n'écrit jamais la valeur d'un mot
de passe ou d'une clé, seulement son nom et l'endroit où elle vit.

## Ça marche pour quel genre de travail

Tous. La méthode classe l'information par sa nature (une décision, une règle,
une habitude, un fait, un lien) et non par le métier. Ces cinq catégories
existent aussi bien dans un audit de conformité que dans un développement
logiciel, un travail sur des données ou la rédaction d'un livre.

## Commencer

```sh
git clone https://github.com/Spreadtheflow/cairn.git
cd cairn
./cairn.sh init ~/cairn
```

Puis lisez `INSTALLATION.md`, qui prend une dizaine de minutes.

Vous pouvez aussi tout faire à la main : copiez le dossier `squelette/`,
renommez-le, et lisez `METHODE.md`. **La méthode fonctionne entièrement sans
script, sans agent et sans Obsidian.** Ce sont des accélérateurs, pas des
prérequis.

## Les documents

| Fichier | Pour qui |
|---|---|
| `README.md` | Vous êtes ici |
| `INSTALLATION.md` | Pour mettre en place, dix minutes |
| `METHODE.md` | La spécification complète, si vous voulez comprendre le détail |
| `DOCTRINE.md` | Comment conduire l'échange avec un assistant. La moitié qui ne s'automatise pas |
| `adaptateurs/` | Comment brancher tel ou tel outil |
| `squelette/` | L'arborescence de départ |
| `exemples/` | Un projet complet et fictif, pour voir à quoi ça ressemble une fois habité |

## Licence

CC BY 4.0. Prenez, adaptez, transmettez.
