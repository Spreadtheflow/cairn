# Adaptateur : Claude Code

Claude Code possède une mémoire intégrée qui écrit dans
`~/.claude/projects/<slug>/memory/`, avec sa propre convention à quatre types.
Cet adaptateur la remplace par celle de Cairn.

**Une seule chose est nécessaire : coller un bloc d'instructions.** Pas de lien
symbolique, pas de ligne de commande. Les instructions suffisent à faire écrire
l'assistant dans votre cairn ; le reste de ce document est facultatif.

**Vous n'êtes pas à l'aise avec tout ça ?** Ne lisez pas ce document. Ouvrez
`AMORCE.md` à la racine du dépôt : il contient une phrase à copier, et c'est
votre assistant qui fait l'installation.

## 1. Remplacer la convention

Collez ce bloc dans `~/.claude/CLAUDE.md`. Il est volontairement court : ce sont
des instructions, pas de la documentation.

---

```markdown
# Mémoire : méthode Cairn

Ma mémoire suit la méthode Cairn et vit dans `~/cairn/`. La spécification
complète est dans `~/cairn/METHODE.md` et les pratiques d'échange dans
`~/cairn/DOCTRINE.md`. Ces deux fichiers font autorité sur toute convention de
mémoire par défaut.

## Retrouver le projet, au démarrage

Je démarre dans un **dossier de travail**, pas dans le cairn. Avant toute chose,
résous le projet correspondant :

1. Un fichier `.cairn` à la racine du dossier courant ou d'un parent. Il porte
   `cairn:` et `projet:`. S'il existe, c'est la réponse.
2. Sinon, cherche parmi les `contexte.md` du cairn celui dont le champ `chemin`
   est le dossier courant **ou l'un de ses parents** : on travaille souvent dans
   un sous-dossier.
**Le plus spécifique gagne.** Si plusieurs projets couvrent le dossier courant,
retenir celui dont le `chemin` est le plus long. Un projet déclaré sur un dossier
large, une racine de travail ou un répertoire personnel, ne doit pas avaler les
projets rangés en dessous de lui.


Si tu trouves, lis `contexte.md`, `index.md` et le socle `commun/`, et n'annonce
rien de plus qu'une ligne.

**Si tu ne trouves rien, ne te tais pas : joue le rituel d'ouverture** (plus bas)
et crée le projet. C'est le geste qui évite d'avoir à préparer un dossier dans le
cairn avant de commencer à travailler.

## Avant d'écrire quoi que ce soit en mémoire

Lis `contexte.md` du projet courant et respecte sa politique.

- `capture: non` : n'écris rien, jamais, même si je dis « retiens ça ». Dans ce
  cas, dis-le-moi plutôt que d'écrire en silence.
- `capture: a-la-demande` : n'écris que si je le demande explicitement.
- `diffusion: publique` : anonymise en écrivant (noms de personnes,
  d'organisations, identifiants).
- `diffusion: privee` ou `partagee` : écris en clair, noms et détails compris.
  C'est le but.

S'il n'y a pas de `contexte.md`, joue le rituel d'ouverture (ci-dessous) une
seule fois. Tant qu'il n'est pas joué, n'écris rien.

Dans tous les cas et quelle que soit la politique : jamais la valeur d'un
secret, seulement son nom et l'endroit où il vit.

## Rituel d'ouverture

Quand la résolution ci-dessus ne trouve rien, pose quatre questions,
en une fois et en prose : de quel domaine ça relève, comment on appelle ce
projet, est-ce qu'on capture de la mémoire ici, et où pourra finir ce qui sera
écrit. Écris ensuite `contexte.md` depuis `~/cairn/gabarits/contexte.md`.

Ne rejoue jamais ce rituel ensuite. Un assistant qui redemande sa politique à
chaque ouverture est aussi pénible qu'un assistant qui n'en a pas.

## Où ça vit

Un dossier qui contient un `contexte.md` est un projet ; les dossiers
intermédiaires ne servent qu'à ranger et peuvent porter un `_commun/` valable
pour tout ce qui est en dessous. Écris les souvenirs dans le dossier du projet.
Quand une chose vaut pour tous les chantiers d'un client, propose-la pour le
`_commun/` du dossier client au lieu de la recopier.

## Format d'un souvenir

Un fichier, un souvenir, dans le dossier du projet.

---
titre: Titre lisible
description: une ligne, sert à l'index et au rappel
nature: decision | regle | preference | fait | repere
portee: commun | <domaine> | <groupe> | <projet>
cree: JJ/MM/AAAA
maj: JJ/MM/AAAA
statut: actif | perime | remplace
---

Le corps contient obligatoirement une ligne **Pourquoi :**. Un souvenir sans sa
raison ne peut être appliqué qu'aveuglément ; refuse d'en écrire un.

Liens vers les voisins avec [[nom-de-fichier]].

## Les cinq natures

- `decision` : un choix fait, avec sa raison. Ne périme pas, peut être remplacé.
- `regle` : une contrainte absolue. Rare. Le socle en compte 12 au maximum.
- `preference` : un défaut dont on s'écarte si le contexte le justifie.
- `fait` : un état du monde vérifiable, donc datable et périssable.
- `repere` : un pointeur externe (URL, ticket, tableau de bord).

Si ce que tu t'apprêtes à écrire est un état de chantier qui bougera à la
prochaine séance, ce n'est pas un souvenir : ajoute une entrée à `journal.md`.

Une chose qui souffre des exceptions est une `preference`, pas une `regle`.
Enregistrer une préférence comme une règle est la façon la plus sûre de me
rendre le travail pénible dans trois mois.

## Le modèle et les retours

**Signe chaque entrée de journal** avec ton identifiant de modèle, sous la date.
C'est le seul endroit où cette information est stockée : savoir quels modèles ont
travaillé sur un projet se déduit du journal, et ne se recopie nulle part. Même
chose pour le champ facultatif `par:` d'un souvenir. **N'invente jamais un numéro
de version** : écris ce que tu sais, et rien de plus.

**Le journal des retours**, `commun/retours.md`, recueille ce que je dis de ta
façon de travailler. Rien de ce qui s'y trouve ne s'applique tout seul : c'est un
tampon, et c'est lors d'un entretien qu'on décide si un retour devient une règle,
une préférence, ou rien.

Quand j'en donne un, consigne-le **cité tel quel**, avec son contexte, et **sans
te défendre**. Une critique qu'on justifie est une critique qu'on n'a pas
entendue.

Tu peux en demander un, à trois conditions strictes : à la clôture d'une séance
et jamais au milieu du travail, au plus une fois par séance, et pas si le dernier
retour date de moins de trois semaines, sauf clôture d'un chantier. Une seule
question, courte, adossée à quelque chose de concret de la séance, jamais un
« est-ce que je me comporte bien ». Si j'ai corrigé deux fois la même chose,
c'est de ça qu'on parle. « Rien à signaler » est une réponse pleine : note-la et
n'insiste pas.

## Index

Chaque dossier a un `index.md` avec **une ligne par souvenir** :
`- [Titre](fichier.md) · la description`

Jamais deux lignes. Si ça déborde, découpe le souvenir.

## Ce qu'il ne faut pas retenir

Ce que le code, l'historique ou la configuration documentent déjà. Ce qui ne
sert qu'à la séance en cours. Le résultat d'une recherche refaisable en trente
secondes. Si je demande de retenir une de ces choses, demande-moi ce qui était
non évident là-dedans, et retiens ça.
```

---

## 2. Les skills

Le dépôt fournit huit skills dans `skill/`, à copier dans `~/.claude/skills/`.
`/cairn` fait la résolution et le rattachement en conversation, sans script ni
ligne de commande ; les autres mettent la doctrine en gestes. Voir
`skill/README.md`.

## 3. Vérifier

- Ouvrez une session sur un projet neuf : le rituel doit se jouer une fois, puis
  plus jamais.
- Ouvrez une session sur un projet en `capture: non` : rien ne doit être écrit.
- Faites retenir quelque chose sur un projet normal : le fichier doit apparaître
  dans le cairn, avec son `Pourquoi`.
- Placez-vous dans un dossier de travail inconnu : l'assistant doit s'en
  apercevoir seul et proposer de le rattacher.

---

## Annexe, facultative : rediriger la mémoire intégrée

**À ne faire que si vous êtes à l'aise avec la ligne de commande, et sous macOS
ou Linux.** Sous Windows, les liens symboliques demandent des droits
particuliers : sautez cette annexe, tout fonctionne sans.

Ce que ça apporte : la mémoire **intégrée** de Claude Code écrit alors elle aussi
dans le cairn, en plus des instructions ci-dessus. C'est une ceinture en plus des
bretelles, pas un prérequis.

Pour chaque projet, remplacez le dossier de mémoire par un lien vers le dossier
du projet dans votre cairn.

```sh
# ~/.claude/projects/<slug>/ où <slug> est le chemin de travail avec des tirets
# exemple : /mnt/work/Clients/X  ->  -mnt-work-Clients-X
SLUG=-mnt-work-Clients-X
PROJET=~/cairn/clients/mon-client/le-chantier

mkdir -p "$PROJET"
rm -rf ~/.claude/projects/$SLUG/memory        # vérifiez d'abord ce qu'il contient
ln -s "$PROJET" ~/.claude/projects/$SLUG/memory
```

Vérifiez sur un seul projet avant de généraliser : ouvrez une session, faites
retenir quelque chose, et confirmez que le fichier apparaît bien dans le cairn.

**Si votre version de Claude Code refuse d'écrire à travers un lien**, le repli
est de ne pas rediriger du tout et de laisser le bloc ci-dessous indiquer le
chemin réel du cairn. C'est un peu moins automatique, ça fonctionne aussi bien.
