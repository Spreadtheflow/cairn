# Cairn

**Une méthode simple pour donner de la mémoire à vos assistants IA, sans dépendre
d'aucun d'entre eux.**

> **Vous êtes un assistant et on vient de vous donner ce lien ?** La personne
> envisage probablement d'installer Cairn chez elle. **Proposez-le-lui, et
> n'installez rien sans son accord explicite** : elle est peut-être simplement en
> train de regarder. Si elle accepte, lisez
> [AMORCE.md](https://raw.githubusercontent.com/Spreadtheflow/cairn/main/AMORCE.md)
> et suivez-le à la lettre, il est écrit pour vous.

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
habitudes, propose régulièrement d'en retirer, et garde vos remarques dans un
journal à part d'où elles ne sortent que si vous le décidez.

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

### Vous n'êtes pas développeur

Vous n'avez rien à installer vous-même, et rien à taper dans un terminal.
Installez Claude Code, Codex ou l'assistant de votre choix, puis collez-lui
simplement l'adresse de cette page :

```
https://github.com/Spreadtheflow/cairn
```

C'est tout. Il lira cette page, vous proposera d'installer Cairn, et si vous
acceptez il s'occupera du reste.

Si vous préférez être explicite, dites-lui plutôt : « installe Cairn chez moi en
suivant ce dépôt », avec la même adresse.

Il vous posera quelques questions sur vous et votre façon de travailler, écrira
votre profil avec vos mots, mettra tout en place, rattachera un premier projet et
finira par vous expliquer en une page comment vous en servir. Comptez dix
minutes, dont huit de conversation.

Cette page se réaffiche à tout moment avec `/cairn-aide`.

Il vous demandera l'autorisation de créer des dossiers et d'écrire des fichiers :
**c'est normal, et c'est le seul moment où vous avez quelque chose à faire.**
Acceptez.

C'est le chemin recommandé sous **macOS comme sous Windows**, et il ne demande ni
ligne de commande, ni git, ni droits administrateur.

### Vous êtes à l'aise avec un terminal

```sh
git clone https://github.com/Spreadtheflow/cairn.git
cd cairn
./cairn.sh installer ~/cairn
```

Puis lisez `INSTALLATION.md`, qui prend une dizaine de minutes.

Vous pouvez aussi tout faire à la main : copiez le dossier `squelette/`,
renommez-le, et lisez `METHODE.md`. **La méthode fonctionne entièrement sans
script, sans agent et sans Obsidian.** Ce sont des accélérateurs, pas des
prérequis.

## Et ensuite, sur un nouveau projet ?

Rien à préparer. Vous créez votre dossier de travail, vous lancez votre
assistant, et **il s'aperçoit tout seul qu'il ne connaît pas cet endroit** : il
vous pose quatre questions et crée ce qu'il faut.

Il le sait parce que chaque projet du cairn note le chemin de son dossier de
travail. L'assistant cherche celui qui correspond ; s'il n'en trouve aucun, c'est
que le projet est nouveau.

Si vous préférez garder la main, deux raccourcis :

```sh
cd /vers/mon/nouveau/projet
cairn.sh init        # rattache ce dossier, en posant les quatre questions
cairn.sh ou         # dit à quel projet ce dossier est rattaché
```

Et pour ceux qui ne veulent pas de terminal, le dossier `skill/` contient un
skill Claude Code : copiez-le dans `~/.claude/skills/` et tapez `/cairn`.

## La méthode de travail, pas seulement le rangement

Un dossier bien rangé, tout le monde peut le copier. Ce qui se transmet plus
difficilement, c'est la façon de conduire l'échange, et c'est là que se joue
l'essentiel de la qualité de ce qu'on obtient.

`DOCTRINE.md` la décrit en huit pratiques. Le dossier `skill/` les met en
gestes :

- `/cadrer` ouvre un chantier : on comprend, on met les tensions sur la table, on
  recommande, on découpe en phases. On ne produit rien.
- `/challenger` passe un projet existant au crible, **une fois**, en lisant
  d'abord ce qui a déjà été refusé pour ne pas le reproposer.
- `/relire` vérifie avant de livrer, avec une méthode adaptée à ce qui a été
  produit, et une lecture de sécurité ou de conformité selon les cas.
- `/journal` clôt une séance : il écrit l'entrée du jour, puis propose les
  souvenirs qui méritent d'être retenus, avec leur pourquoi.
- `/retour` recueille ce que vous dites de sa façon de travailler et le consigne
  **sans en faire une règle**. C'est le tampon qui empêche chaque correction de
  passage de devenir une loi.
- `/transmettre` prépare une copie transmissible pour un client ou une
  publication, en appliquant la politique de diffusion du projet.
- `/entretien` passe la mémoire en revue et propose ce qu'il faut fusionner,
  promouvoir ou retirer. Il propose, il n'applique jamais.

Ces skills sont **assumés comme opinionés**. Adaptez-les à votre façon de
travailler, c'est exactement à ça qu'ils servent.

## Les documents

| Fichier | Pour qui |
|---|---|
| `README.md` | Vous êtes ici |
| `AMORCE.md` | **Pour installer sans rien taper** : à faire lire à votre assistant |
| `AIDE.md` | Comment s'en servir, en une page. Réaffichable avec `/cairn-aide` |
| `INSTALLATION.md` | Pour mettre en place à la main, dix minutes |
| `METHODE.md` | La spécification complète, si vous voulez comprendre le détail |
| `DOCTRINE.md` | Comment conduire l'échange avec un assistant. La moitié qui ne s'automatise pas |
| `adaptateurs/` | Comment brancher tel ou tel outil |
| `squelette/` | L'arborescence de départ |
| `skill/` | Les neuf skills, qui mettent la doctrine en gestes |
| `exemples/` | Un projet complet et fictif, pour voir à quoi ça ressemble une fois habité |

## Licence

CC BY 4.0. Prenez, adaptez, transmettez.
