---
name: journal
description: "Clore une séance de travail : écrire l'entrée de journal du jour dans le cairn du projet, puis proposer les souvenirs qui méritent d'être retenus, avec leur pourquoi. Distingue ce qui s'est passé de ce qu'il faut savoir. Utiliser en fin de session, quand l'utilisateur dit qu'on s'arrête, qu'on fait le point, qu'il faut noter ce qu'on a fait, ou avant de fermer un chantier. Déclencheurs : journal, on s'arrête là, fin de séance, noter ce qu'on a fait, faire le point, retiens ça."
---

# Clore une séance

Ce skill applique le point 6 de la doctrine Cairn, documenter au fil de l'eau.
C'est la pratique qu'on saute le plus souvent, parce qu'elle tombe au moment où
l'on est fatigué. Elle est aussi celle dont l'absence coûte le plus cher : ce qui
n'est pas écrit quand c'est évident sera perdu exactement quand ça ne le sera
plus.

## 1. Vérifier la politique avant d'écrire

Lire le `contexte.md` du projet.

- `capture: non` : **n'écrire ni journal ni souvenir.** Le dire, et proposer un
  résumé en conversation à la place.
- `capture: a-la-demande` : ne rien écrire sans demande explicite.
- `diffusion: publique` : anonymiser en écrivant.

Si le projet n'est pas rattaché au cairn, ne rien écrire : proposer d'abord de le
rattacher.

## 2. Écrire l'entrée de journal

Dans `journal.md`, en tête, sous un titre à la date du jour au format JJ/MM/AAAA.
On ajoute, on ne réécrit jamais les entrées passées.

**Signer l'entrée** juste sous la date : qui l'a écrite, un identifiant de
modèle ou un nom de personne. C'est le seul endroit où cette information est
stockée, et c'est elle qui permettra plus tard de savoir quels modèles ont
travaillé sur ce projet. Ne jamais inventer un numéro de version : écrire ce
qu'on sait.

Une entrée courte, qui répond à **ce qui s'est passé** :

- ce qui a été fait, en une ou deux phrases par chose ;
- ce qui a été décidé, avec un renvoi vers le souvenir si on en crée un ;
- ce qui a été découvert, y compris les fausses pistes, qui évitent de les
  reprendre ;
- ce qui reste ouvert, formulé comme une question et non comme une tâche.

Écrire au passé, à la voix active, sans emphase. Un journal se relit six mois
plus tard par quelqu'un qui n'y était pas.

## 3. Proposer les souvenirs

**C'est l'étape qui compte, et c'est là que se joue la distinction centrale : le
journal répond à « que s'est-il passé », la mémoire à « que dois-je savoir ».**

Mérite un souvenir :

- **une décision** prise avec sa raison, surtout un refus motivé ;
- **un fait** vérifiable qu'on aura besoin de retrouver, et qui pourra devenir
  faux, donc daté ;
- **un piège** rencontré, avec ce qui l'a rendu invisible ;
- **une règle ou une préférence** que l'humain a énoncée pendant la séance ;
- **un repère** externe qu'on aura à rouvrir.

Ne mérite pas un souvenir :

- ce que le code, l'historique ou la configuration documentent déjà ;
- un état de chantier qui bougera à la prochaine séance, il appartient au
  journal ;
- ce qui ne servait qu'à cette séance ;
- le résultat d'une recherche refaisable en trente secondes.

Proposer chaque souvenir avec son titre, sa nature, sa description en une ligne
et **son pourquoi**. Renseigner `par:` avec son propre identifiant de modèle. Un souvenir dont on ne sait pas écrire le pourquoi n'est pas
prêt : le dire plutôt que d'inventer une raison.

Signaler les promotions possibles : une chose qui vaut pour tous les chantiers
d'un client va dans son `_commun/`, une chose qui vaut partout est candidate au
socle. **Proposer, jamais promouvoir tout seul.**

## 4. Regarder si un retour est opportun

Avant de conclure, ouvrir `commun/retours.md` et regarder la date du dernier
retour. Si elle remonte à plus de trois semaines, ou si on vient de clore un
chantier, ou si la même chose a été corrigée deux fois dans la séance, poser
**une** question sur la façon de travailler, adossée à quelque chose de concret.
Voir le skill `retour`, qui porte la méthode et les garde-fous.

Sinon, ne rien demander. Une question de trop est plus coûteuse qu'une question
de moins.

## 5. Écrire, puis rendre compte

Après validation, écrire les souvenirs retenus et mettre l'`index.md` à jour, une
ligne par souvenir.

Terminer par trois lignes : l'entrée écrite, les souvenirs créés, ce qui reste
ouvert pour la prochaine fois.

## Ce qu'il ne faut pas faire

- Écrire un souvenir sans pourquoi.
- Recopier dans la mémoire ce qui est déjà dans le journal.
- Transformer les points ouverts en liste de tâches à cocher : c'est un carnet à
  tenir, et personne ne le tient.
- Réécrire une entrée de journal passée pour la corriger. On en ajoute une
  nouvelle qui dit ce qui a changé.
