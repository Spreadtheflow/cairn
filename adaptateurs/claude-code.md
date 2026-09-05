# Adaptateur : Claude Code

Claude Code possède une mémoire intégrée qui écrit dans
`~/.claude/projects/<slug>/memory/`, avec sa propre convention à quatre types.
Cet adaptateur fait deux choses : il redirige cette mémoire vers votre cairn, et
il remplace la convention native par celle de Cairn.

## 1. Rediriger

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

## 2. Remplacer la convention

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

## 3. Le skill, pour ceux qui ne veulent pas de terminal

Le dépôt fournit un skill `cairn` (dans `skill/cairn/`), à copier dans
`~/.claude/skills/cairn/`. Invoqué par `/cairn`, il fait la résolution et le
rattachement conversationnellement, sans script ni ligne de commande.

## 4. Vérifier

- Ouvrez une session sur un projet neuf : le rituel doit se jouer une fois, puis
  plus jamais.
- Ouvrez une session sur un projet en `capture: non` : rien ne doit être écrit.
- Faites retenir quelque chose sur un projet normal : le fichier doit apparaître
  dans le cairn, avec son `Pourquoi`.
- Placez-vous dans un dossier de travail inconnu : l'assistant doit s'en
  apercevoir seul et proposer de le rattacher.
