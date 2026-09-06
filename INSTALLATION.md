# Installation à la main

**Pas à l'aise avec un terminal ?** Collez l'adresse du dépôt à votre assistant,
il installe tout. Voir `AMORCE.md`. Ce qui suit est pour ceux qui préfèrent
faire eux-mêmes. Dix minutes.

## 1. Créer le cairn

```sh
git clone https://github.com/Spreadtheflow/cairn.git
cd cairn
./cairn.sh installer ~/cairn
```

À la main, c'est pareil : copier `squelette/` sous le nom `~/cairn`, y ajouter
`gabarits/`, `METHODE.md`, `DOCTRINE.md` et `AIDE.md`.

## 2. Le profil et la voix

`~/cairn/commun/profil.md` : qui vous êtes, ce que vous faites, comment vous
travaillez. Une trentaine de lignes, lues à chaque session. C'est l'étape que
tout le monde saute et celle qui rapporte le plus.

`~/cairn/commun/voix.md` : comment vous écrivez. Pas de tête : prenez trois ou
quatre textes de vous, notez ce qui revient, un extrait par trait. Le skill
`/voix` le fait avec vous.

## 3. Brancher l'assistant

Coller le bloc de `adaptateurs/claude-code.md` à la fin de `~/.claude/CLAUDE.md`,
marqueurs compris. Pour un autre outil, `adaptateurs/agents-md.md` donne le
fichier de chacun. Une mémoire Claude Code à récupérer : `adaptateurs/migration-depuis-claude.md`.

Les skills :

```sh
mkdir -p ~/.claude/skills && cp -R skill/* ~/.claude/skills/
```

Pour la plupart des autres outils, `~/.agents/skills/` à la place.

## 4. Un premier projet

```sh
cd /vers/mon/projet
cairn.sh init
```

Quatre questions, une seule fois. Ou ne rien faire : l'assistant, lancé depuis
le dossier, s'apercevra qu'il ne le connaît pas et proposera de le rattacher.
`cairn.sh init --aucun` déclare qu'un dossier n'aura jamais de mémoire.

Puis `cairn.sh verifier` dit ce qui manque encore, et `cairn.sh aide` rappelle
comment ça marche.

---

## Facultatif

**Git.** Recommandé dès le premier jour : vous voyez ce que l'assistant écrit,
et vous annulez une mauvaise écriture d'une commande. `git init` dans `~/cairn`,
un dépôt distant privé si vous voulez. Un cairn est stocké en clair, ce n'est
pas un coffre.

**Obsidian.** Ouvrez `~/cairn` comme coffre, rien à convertir. Un réglage : dans
Fichiers et liens, format de lien sur « chemin absolu dans le coffre ».

**Téléphone.** Obsidian mobile veut une copie locale : Syncthing sur Android, sans
service tiers ; Obsidian Sync ou LiveSync sur iOS. Si vous utilisez git et un
synchroniseur sur le même dossier, excluez `.git/` du synchroniseur.

**Entretien.** Une fois par semaine ou par mois, `/entretien` puis `/arbitrer` :
doublons, règles jamais déclenchées, décisions remplacées, états de chantier
restés en mémoire. `cairn.sh index` recale les index sur les en-têtes. Un
entretien automatisé doit proposer et ne jamais appliquer.

**Mise à jour.** `cairn.sh methode` compare vos copies de la méthode au dépôt,
`--appliquer` les aligne, sans toucher à votre mémoire. Ce que vous avez adapté
est fusionné, ou laissé tel quel en cas de conflit.
