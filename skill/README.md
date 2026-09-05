# Les skills

Un cairn bien rangé se copie. Une méthode de travail encodée, non. **C'est ici
qu'est la spécificité de Cairn** : ces skills mettent la doctrine en gestes.

Ils sont **assumés comme opinionés**. Ils ne décrivent pas une bonne pratique
générale, ils décrivent une façon de travailler. Adaptez-les, c'est le but.

## Installation

Pour Claude Code, tout d'un coup :

```sh
mkdir -p ~/.claude/skills && cp -R skill/* ~/.claude/skills/
```

Puis `/cadrer`, `/challenger`, `/relire`, `/entretien`, `/cairn`.

Pour un autre outil, ce sont des fichiers Markdown : leur contenu se colle en
instruction, ou se garde ouvert à côté. Aucun n'est nécessaire au fonctionnement
de la méthode.

## Ce qu'ils font

| Skill | Ce qu'il fait | Point de doctrine |
|---|---|---|
| `cairn` | Rattache un dossier de travail à sa mémoire, ou crée le projet | La méthode |
| `cadrer` | Ouvre un chantier : échange en prose, tensions, phases | 1 |
| `challenger` | Passe un projet au crible, une fois, sans bloquer | 2 |
| `relire` | Vérifie avant de livrer, selon la nature du produit, sécurité et conformité comprises | 8 |
| `entretien` | Passe le cairn en revue, propose fusions, promotions et retraits | Les garde-fous |

`cadrer` et `relire` ouvrent et ferment la même boucle : on cadre avant, on
éprouve après. `challenger` s'utilise sur de l'existant, `entretien` sur la
mémoire elle-même.

## Écrire le vôtre

Un skill mérite d'exister quand il y a une **procédure répétable qui demande du
jugement**. Si c'est purement mécanique, un script suffit ; si c'est purement du
jugement, c'est de la doctrine, pas un skill.

Trois choses font un bon skill dans cet esprit :

1. **Il commence par aller lire ce qui existe** dans le cairn, pour ne pas
   re-litiger ce qui a été arbitré.
2. **Il dit ce qu'il ne faut pas faire**, pas seulement ce qu'il faut faire. Les
   refus motivés sont ce qui se perd le plus vite.
3. **Il s'arrête et rend la main.** Un skill qui décide à la place de la personne
   reproduit exactement le problème que Cairn cherche à éviter.

Et un skill que personne n'invoque est de l'encombrement : mieux vaut en avoir
quatre qui servent que douze qui dorment.
