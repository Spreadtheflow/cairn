---
name: pierre
description: "Poser une pierre au cairn : retenir tout de suite ce qui vient d'être dit ou décidé, un seul souvenir avec son pourquoi, sans clore la séance. Utiliser quand l'utilisateur dit pierre, retiens, note ça, garde ça, à retenir, ou de sa propre initiative dès qu'une décision est prise avec sa raison, qu'un piège est rencontré, ou qu'une règle ou une préférence est énoncée. Déclencheurs : pierre, retiens, note ça, garde ça, à retenir, souviens-toi, on retient. En anglais : stone, remember this, keep this, note this."
---

# Poser une pierre

Un cairn, c'est un tas de pierres que chaque marcheur fait grossir en passant.
Ce skill pose **une pierre** : un souvenir, maintenant, pendant que la raison est
encore fraîche. Il applique le point 6 de la doctrine, documenter au fil de
l'eau, et il ne clôt rien : la séance continue.

**L'assistant le déclenche lui-même**, sans qu'on le lui demande, dès que l'un de
ces trois cas se présente :

- une décision vient d'être prise, avec sa raison, en particulier un refus ;
- un piège vient d'être rencontré, avec ce qui l'a rendu invisible ;
- l'utilisateur vient d'énoncer une règle ou une préférence.

Ce qui n'attend pas la fin ne se perd pas à la fin.

## 1. Vérifier la politique

Lire le `contexte.md` du projet.

- `capture: non` : ne rien écrire. Le dire en une ligne, et continuer.
- `capture: a-la-demande` : n'écrire que si c'est l'utilisateur qui a dit
  « pierre » ; ne rien poser de sa propre initiative.
- `diffusion: publique` : anonymiser en écrivant.
- Pas de `contexte.md` : ne rien écrire. Proposer de rattacher le dossier
  d'abord, c'est le skill `cairn`.

## 2. Nommer ce qu'on retient

Une pierre, une chose. Si ce qui vient d'être dit contient deux choses, c'est
deux pierres.

Choisir sa nature : `decision`, `regle`, `preference`, `fait` ou `repere`. En cas
de doute entre règle et préférence, c'est une préférence. Une règle nouvelle ne
se pose pas ici : elle va dans `commun/retours.md`, et c'est un entretien qui la
promeut.

Choisir son endroit : le projet courant, sauf si la chose vaut pour tous les
chantiers d'un client, auquel cas la proposer pour son `_commun/`, ou pour tout,
auquel cas la proposer pour le socle. **Proposer, ne pas promouvoir soi-même.**

Ce qui n'est pas une pierre : un état de chantier qui bougera à la prochaine
séance, il va au journal ; ce que le code ou la configuration documentent déjà ;
ce qui ne servait qu'à cette conversation.

## 3. Écrire

Depuis `gabarits/memoire.md` : un titre lisible, une description d'une ligne,
la nature, `cree` et `maj` à la date du jour, `statut: actif`, `par:` avec son
propre identifiant de modèle sans inventer de numéro de version.

Le corps dit la chose en clair, puis **Pourquoi :** avec la raison. **Si on ne
sait pas écrire le pourquoi, la pierre n'est pas prête** : demander la raison en
une phrase, ou ne rien poser. Ne jamais inventer une raison plausible.

Si un souvenir sur le même sujet existe déjà, ne pas en créer un second : mettre
à jour le corps et `maj`, ou, si c'est une décision qui en annule une autre,
passer l'ancienne en `statut: remplace` avec un lien vers la nouvelle.

Ajouter la ligne à `index.md`, une ligne, la description telle quelle. Si
`cairn.sh` est disponible, `cairn.sh index --appliquer` le fait sans erreur.

## 4. Annoncer, en une ligne, et continuer

« Pierre posée : *titre*, dans *projet*. » Rien de plus. Pas de résumé, pas de
question, pas de liste. La séance reprend là où elle était.

Si la pierre a été posée d'initiative et que l'utilisateur la conteste, la
retirer sans discuter : c'est sa mémoire.

## Ce qu'il ne faut pas faire

- Écrire sans pourquoi, ou avec un pourquoi inventé.
- Clore la séance, écrire le journal, proposer un bilan : c'est le skill
  `journal`, et c'est un autre moment.
- Poser une pierre par message. Trois pierres dans une séance est déjà beaucoup ;
  le journal de fin ramasse le reste.
- Promouvoir au socle ou à un `_commun/` de sa propre autorité.
- Écrire dans la mémoire intégrée de l'outil au lieu du cairn.
