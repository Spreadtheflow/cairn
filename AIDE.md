# Cairn, en une page

Votre assistant a maintenant une mémoire. Elle vit dans un dossier à vous, en
fichiers texte que vous pouvez lire, corriger et emporter.

## Comment ça marche

**Vous travaillez normalement.** Votre assistant retient ce qui mérite de l'être :
les décisions et leur raison, les pièges rencontrés, ce que vous lui demandez de
faire ou de ne plus faire.

**Il retrouve la mémoire tout seul.** Quand vous ouvrez un dossier qu'il connaît,
il sait où est sa mémoire. Quand il ne connaît pas l'endroit, il vous pose quatre
questions une seule fois et le rattache.

**Rien ne devient une règle sans vous.** Vos remarques sont gardées dans un
journal à part. Elles ne deviennent des consignes permanentes que si vous le
décidez. C'est ce qui l'empêche de se rigidifier avec le temps.

**Il écrit avec votre voix.** Un mail, un article, un message rédigé en votre
nom suit la façon dont vous écrivez, notée une fois dans un fichier à vous, et
qui ne dépend d'aucun outil.

## Deux mots à connaître

**« pierre »** : retenir tout de suite ce qu'on vient de dire ou de décider. Il
le fait aussi tout seul quand une décision est nette, et vous le dit en une
ligne.

**« fin »** : clore la séance. Il note ce qui s'est passé et vous propose ce qui
mérite d'être retenu. Il vous le proposera de lui-même quand la conversation se
termine.

Rien d'autre à retenir. Le reste, c'est lui qui s'en charge.

## Ce que vous n'avez pas à faire

Ranger, classer, ouvrir un fichier, taper une commande, lui rappeler le contexte
au début d'une séance.

Si vous voulez lire ce qu'il a retenu, ouvrez le dossier. Tout est en texte, et
rien n'est caché.

## Les raccourcis

Tapez `/` dans votre assistant pour les voir. Aucun n'est obligatoire, ils font
gagner du temps sur des gestes qui reviennent.

| | |
|---|---|
| `/cairn` | Rattacher le dossier courant à sa mémoire, ou dire qu'il n'en aura jamais |
| `/cairn-aide` | Réafficher cette page, et mettre Cairn à jour |
| `/pierre` | Retenir tout de suite une chose, avec sa raison. Le mot : « pierre » |
| `/journal` | Clore une séance : noter ce qui s'est passé, retenir ce qui compte. Le mot : « fin » |
| `/cadrer` | Ouvrir un chantier : comprendre, arbitrer, découper avant de produire |
| `/challenger` | Faire critiquer un projet ou une idée, une fois, sans blocage |
| `/relire` | Vérifier avant de livrer, selon ce qui a été produit |
| `/retour` | Dire ce qui vous convient ou non dans sa façon de travailler |
| `/voix` | Établir votre façon d'écrire, à partir de textes de vous |
| `/transmettre` | Préparer une copie à donner à quelqu'un, ou à publier |
| `/entretien` | Faire le ménage : il repère et propose, il ne touche à rien |
| `/arbitrer` | Trancher ces propositions : ce que vous gardez est appliqué |

## Les quatre fichiers qui comptent

Dans votre cairn :

- `commun/profil.md` : qui vous êtes et comment vous travaillez. Lu à chaque
  séance. Si une seule chose mérite d'être corrigée à la main, c'est celui-là.
- `commun/voix.md` : comment vous écrivez. Établi à partir de vos textes, pas
  de ce que vous en dites.
- `commun/regles.md` : vos règles absolues. **Douze au maximum**, volontairement.
  Au-delà, il faut en retirer une pour en ajouter une.
- `commun/retours.md` : ce que vous dites de sa façon de travailler.

Et dans chaque projet, `contexte.md` dit de quoi il s'agit et ce qu'on a le droit
d'y retenir.

## Garder la méthode à jour

Votre cairn contient des copies de la méthode : `METHODE.md`, les gabarits, les
skills, les instructions de votre assistant. Le projet évolue, ces copies non.

Dites-lui « **mets Cairn à jour** ». Il compare, vous dit ce qui a changé, et
aligne ce que vous acceptez. Il ne touche **jamais** votre mémoire : ni
`commun/`, ni un projet, ni un journal. Ce que vous avez adapté vous-même est
fusionné, ou laissé tranquille s'il ne sait pas faire.

Avec un terminal, c'est `cairn.sh methode`, puis `cairn.sh methode --appliquer`.
Et `cairn.sh verifier` dit en une commande ce qui manque encore.

## Une bonne habitude, une seule

Dites « fin » avant de fermer. C'est le geste qui fait la différence sur la
durée, et c'est le seul qu'on vous demande.

## Pour aller plus loin

`METHODE.md` décrit le rangement, `DOCTRINE.md` la façon de travailler. Les deux
sont dans votre cairn. Vous n'avez pas besoin de les lire pour vous en servir.
