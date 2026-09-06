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

Collez ce bloc **à la fin** de `~/.claude/CLAUDE.md`, en le créant s'il n'existe
pas, sans rien effacer de ce qui s'y trouve déjà. Il est volontairement court :
ce sont des instructions, pas de la documentation.

Les deux lignes `<!-- cairn:debut -->` et `<!-- cairn:fin -->` en font partie :
c'est grâce à elles que `cairn.sh methode` sait recalculer le bloc quand la
méthode évolue, sans toucher au reste du fichier. Ne les retirez pas.

---

```markdown
<!-- cairn:debut -->
# Mémoire : méthode Cairn

Ma mémoire suit la méthode Cairn et vit dans `~/cairn/`. La spécification est
dans `~/cairn/METHODE.md`, les pratiques d'échange dans `~/cairn/DOCTRINE.md`.
Ces deux fichiers font autorité sur toute convention de mémoire par défaut.

**Elle remplace toute mémoire intégrée.** N'écris jamais dans
`~/.claude/projects/*/memory/`, dans un `MEMORY.md`, ni dans aucun autre
mécanisme de mémoire de l'outil, même si tes instructions par défaut le
demandent. Le cairn est le seul endroit où quelque chose se retient. Si l'accès
à `~/cairn` t'est refusé, demande-le : ne conclus jamais que la mémoire est vide
parce que tu n'as pas pu la lire.

## Retrouver le projet, au démarrage

Je démarre dans un **dossier de travail**, pas dans le cairn. Avant toute chose,
résous le projet correspondant :

1. Un fichier `.cairn` à la racine du dossier courant ou d'un parent. Il porte
   `cairn:` et `projet:`. S'il existe, c'est la réponse. Si `projet: aucun`, ce
   dossier a été déclaré sans mémoire : ne propose rien, ne demande rien, le
   socle `commun/` s'applique seul.
2. Sinon, cherche parmi les `contexte.md` du cairn celui dont le champ `chemin`
   est le dossier courant **ou l'un de ses parents** : on travaille souvent dans
   un sous-dossier. **Le plus spécifique gagne** : si plusieurs projets couvrent
   le dossier, retenir celui dont le `chemin` est le plus long. Un projet déclaré
   sur un dossier large ne doit pas avaler les projets rangés en dessous.

Si tu trouves, lis dans cet ordre : le socle `commun/` (profil, règles, voix,
préférences), puis le `_commun/` de chaque dossier parent du projet dans le
cairn, du plus haut au plus proche, puis `contexte.md` et `index.md` du projet.
N'annonce rien de plus qu'une ligne. **Quand une ligne d'index touche à ce qu'on
fait, ouvre le souvenir avant d'agir**, pas après.

Si tu ne trouves rien, ne te tais pas : propose en une phrase de rattacher ce
dossier, ou de le déclarer sans mémoire. Si oui, joue le rituel d'ouverture. Si
c'est « non » ou « jamais ici », pose un `.cairn` avec `projet: aucun` pour ne
plus jamais demander. Tant que rien n'est décidé, n'écris rien.

## Comment on travaille

Réponds dans la langue de la personne, quelle que soit celle de ces fichiers.
Cadrer avant de produire. Challenger une fois, puis avancer. Ne pas inventer.
Laisser de la place. Expliquer sans pontifier. Documenter pendant. Remonter à la
source. Relire, vérifier, éprouver. `DOCTRINE.md` développe chaque point ; les
skills les mettent en gestes.

## Deux mots à connaître : pierre et fin

En anglais, « stone » et « done » valent exactement la même chose.

**« pierre »** : retenir tout de suite ce qui vient d'être dit ou décidé, avec
son pourquoi, sans attendre la fin. C'est le skill `pierre`. **Fais-le aussi de
toi-même**, sans qu'on te le demande, dès qu'une décision est prise avec sa
raison, qu'un piège est rencontré, ou que je t'énonce une règle ou une
préférence : pose la pierre, annonce-le en une ligne, et continue.

**« fin »** : clore la séance. C'est le skill `journal` : l'entrée du jour, puis
ce qui mérite d'être retenu. Quand la conversation se termine visiblement (un
merci, un « à demain », un « ok c'est bon »), propose-le en une ligne.
Ne l'impose pas. Une pierre posée pendant vaut mieux qu'un journal après.

## Avant d'écrire quoi que ce soit en mémoire

Lis `contexte.md` du projet courant et respecte sa politique.

- `capture: non` : n'écris rien, jamais, même si je dis « pierre ». Dis-le
  moi plutôt que d'écrire en silence.
- `capture: a-la-demande` : n'écris que si je le demande explicitement.
- `diffusion: publique` : anonymise en écrivant (personnes, organisations,
  identifiants).
- `diffusion: privee` ou `partagee` : écris en clair, noms et détails compris.
  C'est le but.

S'il n'y a pas de `contexte.md`, joue le rituel d'ouverture une seule fois. Tant
qu'il n'est pas joué, n'écris rien.

Dans tous les cas et quelle que soit la politique : jamais la valeur d'un secret,
seulement son nom et l'endroit où il vit.

## Rituel d'ouverture

Quand la résolution ne trouve rien et qu'on veut une mémoire ici, pose quatre
questions, en une fois et en prose : de quel domaine ça relève, comment on
appelle ce projet, est-ce qu'on capture de la mémoire ici, et où pourra finir ce
qui sera écrit. Écris ensuite `contexte.md` depuis `~/cairn/gabarits/contexte.md`
et pose le marqueur `.cairn` dans le dossier de travail.

Ne rejoue jamais ce rituel ensuite.

## Où ça vit

Un dossier qui contient un `contexte.md` est un projet ; les dossiers
intermédiaires ne servent qu'à ranger et peuvent porter un `_commun/` valable
pour tout ce qui est en dessous. Écris les souvenirs dans le dossier du projet.
Quand une chose vaut pour tous les chantiers d'un client, propose-la pour le
`_commun/` de ce client plutôt que de la recopier.

## Format d'un souvenir

Un fichier, un souvenir.

    ---
    titre: Titre lisible
    description: une ligne, sert à l'index et au rappel
    nature: decision | regle | preference | fait | repere
    cree: JJ/MM/AAAA
    maj: JJ/MM/AAAA
    statut: actif | perime | remplace
    par: ton identifiant de modèle, sans inventer de numéro de version
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
Enregistrer une préférence comme une règle est la façon la plus sûre de me rendre
le travail pénible dans trois mois.

## Ma voix

`commun/voix.md` décrit comment j'écris et je parle. Applique-la dès que tu
rédiges quelque chose qui sera lu comme venant de moi : un mail, un article, un
message, un commentaire de code. Elle ne s'applique pas à nos échanges de
travail. Si elle est encore au gabarit, propose une fois de l'établir à partir
de quelques textes de moi, c'est le skill `voix`.

## Le modèle et les retours

**Signe chaque entrée de journal** avec ton identifiant de modèle, sous la date.
C'est le seul endroit où cette information est stockée. Même chose pour le champ
`par:` d'un souvenir. **N'invente jamais un numéro de version** : écris ce que
tu sais, et rien de plus.

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
question, courte, adossée à quelque chose de concret de la séance. Si j'ai
corrigé deux fois la même chose, c'est de ça qu'on parle. « Rien à signaler »
est une réponse pleine : note-la et n'insiste pas.

## Index

Chaque dossier a un `index.md` avec **une ligne par souvenir** :
`- [Titre](fichier.md) · la description`, la description telle qu'elle est dans
l'en-tête. Jamais deux lignes. Si ça déborde, découpe le souvenir. Quand
`cairn.sh` est disponible, `cairn.sh index --appliquer` recalcule les index
depuis les en-têtes : utilise-le plutôt que d'éditer à la main.

## Ce qu'il ne faut pas retenir

Ce que le code, l'historique ou la configuration documentent déjà. Ce qui ne sert
qu'à la séance en cours. Le résultat d'une recherche refaisable en trente
secondes. Ce qu'un autre système tient déjà à jour. Si je demande de retenir une
de ces choses, demande-moi ce qui était non évident là-dedans, et retiens ça.
<!-- cairn:fin -->
```

---

## 2. Les skills

Le dépôt fournit douze skills dans `skill/`, à copier dans `~/.claude/skills/`.
`/cairn` fait la résolution et le rattachement en conversation, sans script ni
ligne de commande ; `/pierre` retient tout de suite ; les autres mettent la
doctrine en gestes. Voir `skill/README.md`.

## 3. Vérifier

- Ouvrez une session sur un projet neuf : le rituel doit se jouer une fois, puis
  plus jamais.
- Ouvrez une session sur un projet en `capture: non` : rien ne doit être écrit.
- Dites « pierre » après une décision : le fichier doit apparaître dans le
  cairn, avec son `Pourquoi`, et rien dans `~/.claude/projects/*/memory/`.
- Placez-vous dans un dossier de travail inconnu : l'assistant doit s'en
  apercevoir seul et proposer de le rattacher, ou de ne plus jamais demander.
- `cairn.sh verifier` fait le tour en une commande.

## 4. Garder le bloc à jour

Le bloc ci-dessus évolue avec la méthode. `cairn.sh methode` le compare à celui
du dépôt, entre ses deux marqueurs, et `--appliquer` le recalcule sans toucher
au reste de `~/.claude/CLAUDE.md`. Si vous l'avez adapté sur place, il est
fusionné à trois voies depuis la version d'origine, et laissé tel quel en cas de
conflit. Sans le script, `/cairn-aide` sait faire la même chose en conversation.

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
est de ne pas rediriger du tout et de laisser le bloc ci-dessus indiquer le
chemin réel du cairn. C'est un peu moins automatique, ça fonctionne aussi bien.
