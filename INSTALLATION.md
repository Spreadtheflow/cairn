# Installation

**Vous n'êtes pas développeur ?** Ne lisez pas ce document. Ouvrez `AMORCE.md` :
il contient une phrase à copier dans votre assistant, et c'est lui qui installe
tout, en vous posant quelques questions. Aucun terminal, aucun git, aucun droit
administrateur, sous macOS comme sous Windows.

Ce qui suit est le chemin manuel, pour ceux qui préfèrent faire eux-mêmes.

Comptez dix minutes pour le socle. Les accélérateurs viennent après, quand vous
en aurez envie, et aucun n'est obligatoire.

## Étape 1 : créer le cairn

```sh
git clone https://github.com/Spreadtheflow/cairn.git
cd cairn
./cairn.sh installer ~/cairn
```

Ou à la main, ce qui revient exactement au même : copiez le dossier `squelette/`
sous le nom `~/cairn`, ajoutez-y `gabarits/`, `METHODE.md` et `DOCTRINE.md`.

## Étape 2 : remplir le profil

Ouvrez `~/cairn/commun/profil.md` et remplacez le contenu par le vôtre : qui
vous êtes, ce que vous faites, comment vous travaillez. Une trentaine de lignes
au maximum, parce que ce fichier sera lu au début de chaque session.

C'est l'étape que tout le monde saute et c'est celle qui rapporte le plus. Un
assistant qui sait que vous êtes juriste et pas développeur, que vous décidez
vite et détestez les listes d'options, ne produit pas le même travail.

## Étape 3 : brancher votre assistant

Voir le dossier `adaptateurs/` :

- `claude-code.md` pour Claude Code
- `agents-md.md` pour les outils qui lisent un `AGENTS.md` ou équivalent, et
  pour les interfaces web
- `migration-depuis-claude.md` si vous avez déjà une mémoire à récupérer

## Étape 4 : votre premier projet

Placez-vous dans votre dossier de travail et rattachez-le :

```sh
cd /vers/mon/projet
/chemin/vers/cairn.sh init
```

Quatre questions, une seule fois. Le projet est créé dans le cairn, le chemin de
travail y est noté, et un petit fichier `.cairn` est posé dans votre dossier.

**Vous pouvez aussi ne rien faire du tout.** Lancez simplement votre assistant
depuis le dossier : il cherchera le projet correspondant, ne le trouvera pas, et
vous posera les mêmes quatre questions. C'est la voie la plus courte, et celle à
montrer à quelqu'un qui découvre.

Pour savoir où vous en êtes, `cairn.sh ou` dit à quel projet le dossier courant
est rattaché.

Puis travaillez normalement. Les souvenirs viendront tout seuls.

Pour revoir comment ça marche à tout moment : `cairn.sh aide`, ou `/cairn-aide`
si vous avez installé les skills.

### Les skills

Le dossier `skill/` du dépôt contient dix skills Claude Code :

```sh
mkdir -p ~/.claude/skills && cp -R skill/* ~/.claude/skills/
```

`/cairn` rattache un dossier sans passer par le terminal. `/cadrer`,
`/challenger`, `/relire`, `/journal`, `/retour`, `/transmettre`, `/entretien` et
`/arbitrer` mettent la doctrine en gestes : voir `skill/README.md`. Aucun n'est nécessaire au
fonctionnement de la méthode.

---

# Les accélérateurs

Tout ce qui suit est optionnel. Le cairn fonctionne sans.

## Un historique, avec git

Fortement recommandé dès le premier jour, surtout si un agent écrit dans votre
cairn : vous voyez ce qui a changé, et vous annulez une mauvaise écriture d'une
commande.

```sh
cd ~/cairn
git init
git add -A && git commit -m "Premier cairn"
```

Pour un dépôt distant, un dépôt **privé** chez un hébergeur ou un dépôt nu sur
votre propre serveur font aussi bien l'affaire. Rappel de la section 4 de
`METHODE.md` : un cairn est stocké en clair, ce n'est pas un coffre.

## Une vraie interface de lecture, avec Obsidian

Ouvrez `~/cairn` comme coffre. Il n'y a rien à convertir : les en-têtes
deviennent des propriétés et les `[[liens]]` fonctionnent nativement.

Un réglage à faire, dans Fichiers et liens : passez le format de lien sur
**chemin absolu dans le coffre**. Sans ça, deux projets qui auraient chacun un
fichier au même nom rendraient les liens ambigus.

## Le consulter depuis un téléphone

Obsidian mobile travaille sur une copie locale de l'appareil : il ne sait pas
ouvrir un dossier distant. Il faut donc un mécanisme de synchronisation.

Sur Android, **Syncthing** fait ça très bien, sans service tiers, et il peut
passer par un serveur toujours allumé pour que le téléphone se synchronise même
quand l'ordinateur est éteint. Sur iOS, Syncthing n'est pas praticable : les
solutions sont Obsidian Sync, ou Obsidian LiveSync avec une base CouchDB si vous
auto-hébergez.

**Un piège à éviter :** si vous utilisez git *et* un synchroniseur temps réel sur
le même dossier, excluez `.git/` du synchroniseur (`.stignore` pour Syncthing).
Sinon deux machines qui commitent chacune de leur côté finiront par corrompre le
dépôt. Git porte l'historique sur les ordinateurs, le synchroniseur porte les
notes vers le téléphone, et les deux ne se marchent pas dessus.

## Un entretien régulier

Un cairn qui n'est jamais relu s'encrasse. Une fois par semaine ou par mois,
selon votre rythme, relisez et arbitrez :

- des souvenirs en double, ou qui disent presque la même chose
- des règles jamais déclenchées depuis longtemps
- des décisions annulées par une décision plus récente
- des états de chantier qui traînent en mémoire au lieu d'être au journal
- des choses qui reviennent dans plusieurs projets et méritent de monter dans
  le socle commun

Vous pouvez confier ce passage en revue à un agent, à une condition : **qu'il
propose et n'applique pas**. Faites-lui écrire ses propositions dans un fichier
daté que vous relisez. Un entretien automatique qui modifie la mémoire sans
arbitrage humain, c'est le carcan par la porte de service, et c'est précisément
ce que les garde-fous de la section 9 de `METHODE.md` cherchent à empêcher.

## Faire le ménage dans les traces de vos outils

Beaucoup d'assistants conservent l'intégralité des conversations sur le disque.
Ce ne sont pas des souvenirs, ce sont des traces : elles se comptent vite en
centaines de mégaoctets et personne ne les relit jamais.

Fixez-vous une rétention, quelques mois par exemple, et purgez. Ce qui méritait
d'être retenu est déjà dans le cairn.
