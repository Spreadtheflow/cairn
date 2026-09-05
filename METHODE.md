# La méthode Cairn

Ce document est la spécification. Il décrit ce qu'est un cairn, comment il est
rangé, ce qu'on y écrit et ce qu'on n'y écrit pas. Pour une présentation courte,
voir `LISEZMOI.md`. Pour les pratiques d'échange avec un agent, voir `DOCTRINE.md`.

## 1. Principes

**Local first.** Un cairn est un dossier de fichiers Markdown sur votre disque.
Pas de base de données, pas de service, pas de compte. Vous pouvez le lire, le
modifier et le sauvegarder avec un éditeur de texte et rien d'autre.

**Agnostique.** Aucun outil n'est requis. Les agents, Obsidian, git et
l'automatisation se branchent sur le cairn par des adaptateurs ; ils ne le
possèdent pas. Changer de modèle ou d'éditeur, c'est écrire un nouvel
adaptateur de quelques lignes, pas refaire son organisation.

**Lisible des deux côtés.** Le même fichier doit être compréhensible par un
humain qui l'ouvre et exploitable par un programme qui le parse. D'où le
Markdown avec un en-tête structuré, et rien de plus exotique.

**Une mémoire qui accumule devient un carcan.** C'est le mode de défaillance
naturel de tout système de mémoire : chaque préférence enregistrée se transforme
en loi, chaque correction ponctuelle devient une règle permanente, et au bout de
quelques mois l'assistant n'assiste plus, il fait la police. La section 9 décrit
les quatre garde-fous qui existent uniquement pour empêcher ça.

## 2. Structure

```
cairn/
  commun/                  (réservé) le socle global
    profil.md              qui je suis, comment je travaille
    regles.md              les règles absolues, plafonnées à 12
    index.md
    *.md                   faits et repères valables partout
  archive/                 (réservé) périmé mais pas jeté
  gabarits/                (réservé) les modèles de fichiers
  clients/                 un domaine
    _commun/               ce qui vaut pour tout le domaine
    orsay-mutuelle/        un groupe : pas de contexte.md
      _commun/             la fiche client, les interlocuteurs
      audit-conformite/    un projet : il a un contexte.md
        contexte.md        identité du projet et politique de capture
        index.md           une ligne par mémoire, jamais plus
        journal.md         chronologique, on ajoute, on ne réécrit pas
        *.md               les mémoires
      refonte-intranet/    un autre projet du même client
  perso/                   un autre domaine
    ma-maison/
```

Trois sortes de dossiers, et une seule règle pour les distinguer.

- Un **domaine** est un dossier à la racine. C'est un cloisonnement de vie.
- Un **projet** est un dossier qui contient un `contexte.md`. C'est là que
  vivent les souvenirs. Un projet ne contient pas d'autre projet.
- Un **groupe** est un dossier intermédiaire sans `contexte.md` : un client, une
  gamme, une année, ce que votre activité réclame. Il sert à ranger.

Les groupes s'imbriquent librement, aussi profond que nécessaire. `commun`,
`archive` et `gabarits` sont des noms réservés à la racine.

Chaque dossier peut porter un `_commun/`, qui contient ce qui vaut pour tout ce
qui se trouve en dessous de lui et pas au-delà. La fiche d'un client, ses
interlocuteurs et ses conventions vont là, une seule fois, plutôt que d'être
recopiées dans chacun de ses projets.

**Un projet qui grossit devient un groupe.** Le jour où un chantier se scinde en
plusieurs, créez un sous-dossier et descendez-y le `contexte.md` : le dossier
parent cesse d'être un projet et devient un groupe, avec son `_commun/`. Rien
d'autre ne bouge. C'est la seule opération de restructuration que la méthode
demande de connaître.

Un projet est identifié par un **nom stable** en minuscules avec des tirets
(`audit-conformite`), jamais par son chemin sur le disque de travail. Ce chemin
est une simple ligne de `contexte.md` : déplacer ou renommer le dossier de
travail ne casse rien, il suffit de corriger cette ligne.

Cette indirection n'est pas théorique. Les outils qui rangent leur mémoire par
chemin de travail perdent la trace au premier renommage, et un chemin encodé
dans un identifiant est souvent irrécupérable : rien ne distingue un dossier
`mon projet` d'un dossier `mon-projet` une fois l'espace remplacé par un tiret.

## 3. Domaines et groupes

Un domaine est un cloisonnement physique, pas une étiquette décorative. C'est ce
qui permet d'exporter, de partager ou de sauvegarder une partie sans le reste, et
de ne pas mélanger deux vies dans le même sac.

La méthode livre `pro` et `perso` par défaut. Un domaine s'ajoute en créant un
dossier, parce que toutes les activités n'ont pas le même découpage : une agence
voudra peut-être `clients`, `interne` et `perso`, quelqu'un d'autre encore autre
chose.

**Votre propre structure est un domaine, pas un client.** L'erreur classique
consiste à ranger sa propre agence, son association ou son équipe parmi les
clients, parce que le dossier de travail est au même endroit sur le disque. Ce
qui vous appartient n'a ni le même cycle de vie, ni la même diffusion, ni les
mêmes interlocuteurs : c'est un domaine à part. Le contexte de production de
votre propre parc n'a rien à faire dans le commun de vos clients.

Les groupes, eux, ne cloisonnent rien : ils rangent. Le bon réflexe est de
n'en créer un que lorsqu'il y a effectivement plusieurs projets à mettre dedans,
et de laisser un projet seul à plat en attendant. Une arborescence profonde
construite à l'avance pour des projets qui n'existent pas encore est une
arborescence qu'on abandonne.

Le domaine est le grain du partage **souple**. Pour un cloisonnement **dur**, par
exemple le serveur d'un client qui ne doit rien contenir d'autre, la réponse
n'est pas un dossier mais un cairn séparé. Un dossier ne protège rien, il range.

## 4. Politique de capture

Deux décisions, prises une fois à la création du projet, par un humain et en
connaissance de cause. Elles vivent en tête de `contexte.md`.

```yaml
---
projet: mon-client-x
domaine: pro
chemin: /chemin/vers/le/dossier/de/travail
capture: oui          # oui | non | a-la-demande
diffusion: privee     # privee | partagee | publique
---
```

### capture

Dit si ce projet mérite une mémoire. `non` est un choix légitime et fréquent :
beaucoup de travaux ne laissent rien qui vaille d'être retenu, et une mémoire
vide vaut mieux qu'une mémoire de bruit. `a-la-demande` veut dire qu'on n'écrit
que si on le demande explicitement.

### diffusion

Répond à la seule question qui gouverne la forme de ce qu'on écrit : **où va
finir ce texte**.

Ce champ ne porte pas sur la sensibilité intrinsèque des données. Le nom d'un
client dans le cairn de ce client n'est pas un risque, c'est précisément ce qui
rend la mémoire utile : devoir redonner le contexte à chaque session serait le
contraire d'une mémoire.

- `privee`, le défaut. On écrit en clair, noms et détails compris, sans détour.
- `partagee`. Le cairn du projet sera remis à un client ou à un collègue. On
  écrit toujours en clair, mais rien qu'on n'assumerait pas devant le lecteur.
- `publique`. Ce qui est écrit ici peut finir publié : une méthode, un cas
  d'usage, un dépôt ouvert. On anonymise au moment d'écrire, et `contexte.md`
  porte la table de correspondance en restant, lui, hors du partage.

### Ce que la méthode fait et ne fait pas

Elle **informe, elle ne bloque pas**. Le contenu d'un cairn est stocké en clair,
versionné, et selon votre installation synchronisé jusque sur votre téléphone.
C'est dit franchement pour que la décision soit prise en connaissance de cause.
Le reste relève de votre jugement, pas de l'outil.

Une seule chose ne dépend d'aucune politique : **jamais de valeur de secret dans
un cairn**. On note le nom du secret et l'endroit où il vit, jamais sa valeur.
Ce n'est pas un arbitrage, c'est une règle.

## 5. Retrouver le projet, et le rituel d'ouverture

### Retrouver le projet depuis le dossier de travail

Un assistant démarre dans un **dossier de travail**, pas dans le cairn. Il faut
donc qu'il sache remonter au projet correspondant. La méthode ne demande aucun
registre à tenir, parce que le lien est **déjà écrit** : chaque `contexte.md`
porte le chemin de son dossier de travail.

La résolution est donc une recherche : parmi les `contexte.md` du cairn, celui
dont le `chemin` contient le dossier courant. C'est instantané sur quelques
dizaines de projets, et surtout **toujours juste**, puisque rien n'est dupliqué.
Un dérivé ne se maintient pas, il se recalcule.

Deux précisions qui comptent. On travaille souvent dans un **sous-dossier**, donc
la comparaison porte sur le dossier courant **et ses parents**. Et quand
plusieurs projets couvrent le dossier, **le plus spécifique gagne** : on retient
le `chemin` le plus long. Sans cette règle, un projet déclaré sur un dossier
large, une racine de travail ou un répertoire personnel, avalerait tous les
projets rangés en dessous de lui.

**Le marqueur, en renfort.** Un fichier `.cairn` de deux lignes peut être posé à
la racine du dossier de travail :

```
cairn: /chemin/vers/le/cairn
projet: clients/orsay-mutuelle/audit-conformite
```

Il n'est pas obligatoire. Il sert dans trois cas : un outil qui ne sait pas
chercher dans le système de fichiers, deux projets dont les chemins se
recouvrent, et un humain qui ouvre le dossier et doit voir d'un coup d'œil qu'une
mémoire existe. Comme il voyage avec le dossier, il survit à un déplacement là où
le `chemin` de `contexte.md` devient faux.

### Le rituel

Quand la résolution ne trouve rien, l'assistant ne se tait pas : **il joue le
rituel**. C'est là qu'est l'automatisation. Personne n'a à créer un dossier dans
le cairn avant de commencer à travailler ; on crée son dossier de travail, on
lance son assistant, et il constate qu'il ne connaît pas l'endroit.

À la première session sur un projet qui n'a pas encore de `contexte.md`, quatre
questions, une seule fois :

1. De quel domaine ça relève ?
2. Comment on appelle ce projet ?
3. Est-ce qu'on capture de la mémoire ici ?
4. Où pourra finir ce qui sera écrit ?

Deux règles encadrent ce rituel.

Il se joue **une seule fois**, à la création. Un assistant qui redemande sa
politique à chaque ouverture, c'est du carcan sous une autre forme.

Le défaut, tant que rien n'est déclaré ou si la personne ne veut pas répondre,
est **ne rien capturer**. L'opt-in protège quelqu'un qui découvre l'outil,
l'opt-out le trahit.

## 6. Les cinq natures

La taxonomie porte sur la nature de l'information, jamais sur le type de projet.
C'est ce qui rend la méthode transposable : ces cinq natures existent dans un
audit de conformité comme dans un développement logiciel, un travail de données
ou un chantier de rédaction. Dès qu'on introduit des catégories métier, la
méthode devient sectorielle et cesse d'être transmissible.

| Nature | Ce que c'est | Périme ? |
|---|---|---|
| `decision` | Un choix fait, avec sa raison et sa date | Non, mais peut être remplacé |
| `regle` | Une contrainte absolue, à appliquer sans discuter | Non, rare, plafonnée |
| `preference` | Un défaut dont on s'écarte si le contexte le justifie | Non |
| `fait` | Un état du monde vérifiable | Oui, d'où la date |
| `repere` | Un pointeur externe : URL, ticket, tableau de bord, doc | Oui |

La distinction entre `regle` et `preference` est le premier garde-fou de la
section 9, et probablement le plus important de toute la méthode.

Deux choses vivent hors de la mémoire :

- le **journal** (`journal.md`), qui répond à « que s'est-il passé » ;
- le **contexte** (`contexte.md`), la fiche d'identité du projet.

La mémoire, elle, répond à « que dois-je savoir ». Confondre les deux est
l'erreur la plus commune : un état de chantier qui bouge à chaque séance n'est
pas un souvenir, c'est une entrée de journal, et le mettre en mémoire fait
gonfler l'index jusqu'à ce qu'il cesse d'indexer.

## 7. Le fichier mémoire

Un fichier, un souvenir. En-tête YAML, puis le corps.

```markdown
---
titre: Titre lisible
description: une ligne, sert à l'index et au rappel
nature: decision
portee: mon-client-x
cree: 05/09/2026
maj: 05/09/2026
statut: actif
---

Le fait, la décision ou la règle, énoncé en clair.

**Pourquoi :** la raison. Obligatoire.

Liens vers les souvenirs voisins avec [[nom-du-fichier]].
```

Champs :

- `titre` : lisible, pas un slug.
- `description` : une ligne, c'est elle qui part dans l'index et qui sert à
  décider si ce souvenir est pertinent. Soignez-la, c'est souvent la seule chose
  qui sera lue.
- `nature` : une des cinq de la section 6.
- `portee` : `commun`, ou le nom d'un domaine, d'un groupe ou d'un projet.
- `cree`, `maj` : en JJ/MM/AAAA.
- `statut` : `actif`, `perime`, ou `remplace` (auquel cas le corps pointe vers
  ce qui l'a remplacé).

**Le Pourquoi est obligatoire.** Un souvenir qui dit « fais X » sans dire
pourquoi ne peut être appliqué qu'aveuglément. Un souvenir qui dit « fais X
parce que Y » permet de reconnaître les situations où Y ne tient pas, et donc de
s'en écarter intelligemment. C'est la seule protection contre l'application
mécanique, et c'est ce qui distingue une mémoire d'un règlement intérieur.

Les liens `[[...]]` sont ceux d'Obsidian. Un lien vers un fichier qui n'existe
pas encore n'est pas une erreur : c'est une note pour plus tard.

## 8. L'index

Chaque dossier qui contient des mémoires porte un `index.md` : une ligne par
souvenir, au format

```
- [Titre](fichier.md) · la description, telle quelle
```

Au-delà d'une trentaine d'entrées, un index peut être **groupé par thème** avec
des sous-titres : c'est de la mise en ordre, pas de la description. Si le
groupement lui-même devient difficile, c'est en général que le projet est devenu
un groupe et que ses chantiers méritent d'être des projets distincts.

**Une ligne. Jamais deux.** L'index est chargé en entier au démarrage d'une
session ; s'il se met à résumer le contenu des fichiers, il devient un document
à part entière et l'économie qu'il devait produire disparaît. Quand une ligne
d'index ne tient plus en une ligne, ce n'est pas l'index qu'il faut agrandir,
c'est le souvenir qu'il faut découper.

## 9. Les quatre garde-fous

Ils existent pour une seule raison : empêcher la mémoire de se transformer en
carcan.

### 9.1 Règle contre préférence

Une **règle** est absolue et se compte sur les doigts d'une main : pas de tel
caractère, telle convention de date. Une **préférence** est un défaut dont on
s'écarte quand le contexte le demande.

Sans cette distinction, toute préférence enregistrée devient un impératif, et
l'assistant se rigidifie séance après séance jusqu'à ne plus laisser de place à
l'improvisation ni à la créativité de la personne qu'il assiste.

### 9.2 Le Pourquoi obligatoire

Voir section 7.

### 9.3 Un plafond

**Douze règles maximum** dans `commun/regles.md`. Au-delà, il faut fusionner ou
retirer, pas ajouter.

La contrainte de taille n'est pas cosmétique : c'est elle qui force l'arbitrage,
et l'arbitrage est ce qui garde une mémoire pertinente. Un système sans plafond
n'a jamais de raison de dire non, donc il dit toujours oui, donc il étouffe.

### 9.4 La péremption

L'entretien d'un cairn propose des retraits autant que des ajouts : règles jamais
déclenchées depuis des mois, chantiers clos depuis longtemps, décisions annulées
par une décision plus récente. Ce qui sort va dans `archive/`, pas à la poubelle.

Une règle méta, à inscrire au socle de tout cairn :

> Une objection se formule une fois, clairement, puis on avance avec la décision
> de l'humain.

## 10. Cycle de vie d'un souvenir

**Naissance.** Quelque chose a été appris qui ne se déduit ni du travail
lui-même ni de son historique. On l'écrit, avec son pourquoi.

**Mise à jour.** Le fait change : on corrige le corps et on met `maj` à jour. On
ne crée pas un second fichier sur le même sujet.

**Remplacement.** Une décision en annule une autre : l'ancienne passe en
`statut: remplace` et pointe vers la nouvelle. On garde la trace, parce que
savoir pourquoi on a changé d'avis vaut souvent plus que la décision elle-même.

**Péremption.** Le souvenir ne sert plus. `statut: perime`, puis déplacement
vers `archive/` lors d'un entretien.

**Promotion.** Un souvenir monte d'un cran quand il vaut pour plus que son
projet : dans le `_commun/` du dossier parent s'il concerne tous les chantiers
d'un client, puis dans celui du domaine, puis dans `commun/` s'il vaut partout.
Une promotion se propose, elle ne s'applique jamais toute seule.

## 11. Ce qu'on n'écrit pas

- Ce que le travail lui-même documente déjà : structure du code, historique des
  versions, contenu d'un fichier de configuration.
- Ce qui ne sert qu'à la séance en cours.
- Les valeurs de secrets, en toute circonstance.
- Le résultat d'une recherche qu'on peut refaire en trente secondes.

Si quelqu'un demande de retenir une de ces choses, la bonne question est :
qu'est-ce qui était non évident là-dedans ? Et on retient ça.

## 12. Conventions d'écriture

- Dates en JJ/MM/AAAA, partout, en-têtes compris.
- Noms de fichiers en minuscules, tirets, sans accent.
- Une idée par fichier.
- Le présent, la voix active, des phrases courtes.
- Dans Obsidian, régler le format de lien sur « chemin absolu dans le coffre »
  pour éviter toute ambiguïté entre deux projets qui auraient un fichier
  homonyme.
