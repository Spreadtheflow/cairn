---
name: arbitrer
description: "Lire les propositions d'un entretien, les présenter de façon décidable, appliquer celles qui sont retenues et consigner celles qui sont écartées avec leur raison. Utiliser quand l'utilisateur veut traiter les propositions d'entretien, faire le tri, valider ou refuser, ou nettoyer sa mémoire. Déclencheurs : arbitrer, propositions, valider, trancher, traiter l'entretien, appliquer les propositions, faire le tri."
---

# Arbitrer les propositions d'un entretien

`/entretien` propose et n'applique jamais. Ce skill est l'autre moitié : c'est ici
que l'humain décide, et **seulement ici** que la mémoire est modifiée.

## 1. Prendre le bon fichier

Le plus récent des `commun/propositions-JJ-MM-AAAA.md`, sauf si un autre est
nommé. S'il y en a plusieurs non traités, le dire et les traiter du plus ancien
au plus récent : un arbitrage rendu sur le premier change souvent le second.

Lire aussi `commun/ecartes.md`, pour ne pas resoumettre ce qui a déjà été refusé.

## 2. Présenter de façon décidable

**Ne pas relire le fichier à voix haute.** Il a été écrit pour être lu une fois ;
votre travail est de le rendre *tranchable*.

Numéroter, grouper par nature d'action, et ordonner par ce qui allège le plus.
**Une ligne par proposition**, qui contient trois choses et rien d'autre : ce qui
est proposé, sur quoi, et pourquoi. Si une ligne demande deux phrases, c'est que
la proposition est mal formulée : reformulez-la, ne la rallongez pas.

Signaler à part les propositions qui **changent une règle du socle** : elles
méritent une phrase de plus, parce qu'elles engagent tout le reste.

Puis se taire et attendre. **Ne pas recommander en bloc**, ne pas dire « je
suggère de tout accepter ». Un avis sur un point précis est utile si on le
demande ; un avis global transforme l'arbitrage en formalité.

## 3. Recueillir la décision

En prose. « Garde 1, 3 et 7, jette le reste » est une réponse complète. Accepter
aussi les réponses partielles : ce qui n'est pas tranché reste au fichier pour la
prochaine fois, et se dit explicitement.

Devant une réponse ambigüe, **demander plutôt que deviner**. Une mémoire fusionnée
par erreur se répare mal.

## 4. Appliquer, une par une

**Rien d'autre que ce qui est explicitement retenu.**

- **Fusion** : réécrire la mémoire qui reste pour qu'elle porte les deux
  contenus, en gardant les deux pourquoi s'ils diffèrent ; supprimer l'autre ;
  corriger l'index et **tout lien `[[...]]` qui pointait vers la disparue**.
- **Promotion** : déplacer le fichier d'un cran, corriger son champ `portee`,
  retirer la ligne de l'index d'origine, l'ajouter à l'index d'arrivée. Si la
  chose existait en plusieurs exemplaires, les supprimer tous.
- **Retrait** : passer `statut: perime`, déplacer vers `archive/`, retirer de
  l'index. **Ne jamais supprimer** : savoir pourquoi une chose a cessé de valoir
  a de la valeur.
- **Remplacement** : l'ancienne passe en `statut: remplace` et son corps pointe
  vers la nouvelle.
- **Reclassement règle vers préférence**, ou l'inverse : changer `nature`, sortir
  la ligne de `regles.md` ou l'y ajouter, et vérifier le plafond de douze.
- **Retour arbitré** : renseigner la ligne « Suite » dans `retours.md`, avec la
  date et le sort retenu.

Mettre `maj` à la date du jour sur tout fichier touché.

## 5. Consigner les refus, et c'est le point qui compte

Ce qui est écarté part dans `commun/ecartes.md`, daté, avec **la proposition et
la raison du refus**.

**Pourquoi c'est essentiel :** sans cette trace, le prochain entretien reproposera
exactement la même chose, et celui d'après aussi. Un assistant qui resoumet
chaque jour ce qu'on a refusé la veille est précisément le carcan que la méthode
cherche à empêcher. Le refus est une décision, il se conserve comme telle.

Formuler la raison en une phrase utilisable : « non, ces deux mémoires se
ressemblent mais servent deux publics » vaut mieux que « refusé ».

## 6. Clore

Déplacer le fichier de propositions traité vers `archive/propositions/`.

Rendre compte en quelques lignes : ce qui a été appliqué, ce qui a été écarté, ce
qui reste en attente. Puis proposer un commit, sans le faire d'autorité.

## Ce qu'il ne faut pas faire

- Appliquer une proposition qui n'a pas été explicitement retenue.
- Supprimer un fichier au lieu de l'archiver.
- Écarter sans écrire la raison.
- Pousser à accepter, ou présenter le tri comme une formalité.
- Traiter un fichier de propositions sans le déplacer ensuite : on le
  reproposerait.
