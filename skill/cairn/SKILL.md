---
name: cairn
description: "Rattache le dossier de travail courant à un projet du cairn, ou crée ce projet s'il n'existe pas. Utiliser quand l'utilisateur demande de rattacher un dossier au cairn, de retrouver la mémoire d'un projet, de créer un projet dans le cairn, ou quand une session démarre dans un dossier de travail dont on ne sait pas s'il a une mémoire associée. Déclencheurs : cairn, rattacher, mémoire du projet, où est ma mémoire, nouveau projet. En anglais : attach, my memory, where is my memory, new project."
---

# Rattacher un dossier de travail à son cairn

Un cairn est une mémoire de projet en Markdown, décrite dans `METHODE.md` à sa
racine. Ce skill fait le lien entre le dossier où l'on travaille et le dossier du
cairn qui porte sa mémoire.

Le cairn se trouve dans `$CAIRN` si la variable est définie, sinon dans `~/cairn`.

## 1. Résoudre

Chercher, dans cet ordre :

1. Un fichier `.cairn` à la racine du dossier de travail ou d'un de ses parents.
   Il porte `cairn:` et `projet:`. S'il existe, la question est réglée. Si
   `projet: aucun`, ce dossier a été déclaré **sans mémoire** : ne rien proposer,
   ne rien demander, s'arrêter là. Seul le socle `commun/` s'applique.
2. Sinon, parmi les `contexte.md` du cairn, celui dont le champ `chemin` est le
   dossier courant ou l'un de ses parents :
   `grep -rl "^chemin: " ~/cairn --include=contexte.md` puis comparer les valeurs.

Attention : on travaille souvent dans un sous-dossier. Comparer le dossier
courant **et ses parents** au `chemin` de chaque projet.
**Le plus spécifique gagne.** Si plusieurs projets couvrent le dossier courant,
retenir celui dont le `chemin` est le plus long. Un projet déclaré sur un dossier
large, une racine de travail ou un répertoire personnel, ne doit pas avaler les
projets rangés en dessous de lui.


Si un projet est trouvé, annoncer où il est en une ligne, puis lire dans cet
ordre : le socle `commun/`, le `_commun/` de chaque dossier parent du projet dans
le cairn, du plus haut au plus proche, puis son `contexte.md` et son `index.md`.
Puis **s'arrêter là**. Ne rien créer.

## 2. Si rien ne correspond, proposer, puis jouer le rituel

Proposer d'abord, en une phrase : rattacher ce dossier à une mémoire, ou le
déclarer sans mémoire pour ne plus jamais poser la question ici. Un dossier
personnel, un bureau, un dossier de téléchargements ne sont pas des projets, et
la bonne réponse y est souvent « jamais ici ».

Si c'est « jamais ici », écrire à la racine du dossier un `.cairn` de deux
lignes, `cairn:` avec le chemin du cairn et `projet: aucun`, dire en une ligne
que c'est fait et comment revenir dessus (supprimer ce fichier), et s'arrêter.

Si c'est oui, poser les quatre questions **en une seule fois, en prose**, jamais
en questionnaire à choix multiples :

1. De quel domaine ça relève ? (annoncer les domaines existants, qui sont les
   dossiers à la racine du cairn hors `commun`, `archive`, `gabarits` et
   `a-trier`)
2. Comment appeler ce projet ? (minuscules et tirets ; proposer un nom déduit du
   dossier courant)
3. Est-ce qu'on capture de la mémoire ici ? (`oui`, `non`, `a-la-demande` ;
   `non` est un choix fréquent et légitime)
4. Où pourra finir ce qui sera écrit ? (`privee` par défaut, `partagee` si le
   dossier sera remis à un client ou un collègue, `publique` si le contenu peut
   être publié, auquel cas on anonymise en écrivant)

Dire franchement, avant de créer : le contenu d'un cairn est stocké en clair,
versionné s'il y a un dépôt git, et synchronisé sur les autres appareils si
l'utilisateur a mis ça en place.

Ne jamais jouer ce rituel deux fois sur le même projet.

## 3. Créer

Si le chemin choisi passe par un dossier intermédiaire qui n'existe pas, le créer
avec son `_commun/index.md` : c'est un groupe, il n'a pas de `contexte.md`.

Refuser de créer un projet **à l'intérieur** d'un projet existant, c'est-à-dire
sous un dossier qui porte déjà un `contexte.md`. Proposer alors de transformer le
parent en groupe en descendant son `contexte.md` d'un cran.

Créer dans le cairn, depuis `gabarits/` :

- `contexte.md`, avec `projet`, `domaine`, `chemin` (le dossier de travail réel),
  `capture`, `diffusion`, `cree` et `maj` au format JJ/MM/AAAA
- `index.md`, titré au nom du projet, vide de contenu
- `journal.md`, avec une première entrée datée

Puis écrire le marqueur à la racine du dossier de travail, `.cairn` :

```
cairn: /chemin/absolu/vers/le/cairn
projet: domaine/groupe/nom
```

Si le dossier de travail est un dépôt git dont le contenu sera partagé et que
l'utilisateur ne veut pas y voir ce fichier, proposer de l'ajouter au
`.gitignore` : la résolution par `contexte.md` suffit à s'en passer.

## 4. Rendre compte

Dire en trois lignes : le dossier de travail, le dossier de mémoire, et la
politique retenue. Si `capture: non`, le redire explicitement, c'est ce qui
gouvernera toute la suite.

## Si le script est disponible

`cairn.sh ou`, `cairn.sh init` et `cairn.sh init --aucun` font exactement ce qui
précède. Les utiliser plutôt que de refaire le travail à la main. Ils ne sont pas
nécessaires : la méthode fonctionne entièrement sans eux.

## Ce qu'il ne faut pas faire

- Créer un projet sans avoir posé les quatre questions.
- Écrire quoi que ce soit en mémoire avant que `contexte.md` existe.
- Rejouer le rituel sur un projet déjà rattaché, ou reposer la question dans un
  dossier déclaré sans mémoire.
- Inventer un `chemin` : c'est le dossier de travail réel, tel qu'il est
  aujourd'hui sur le disque.
