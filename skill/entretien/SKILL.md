---
name: entretien
description: Passer le cairn en revue et proposer ce qu'il faut fusionner, promouvoir au socle commun, ou retirer. Détecte les doublons entre projets, les règles jamais déclenchées, les décisions remplacées et les états de chantier restés en mémoire. Propose dans un fichier daté, n'applique jamais. Utiliser quand l'utilisateur demande de faire le ménage dans sa mémoire, de l'entretenir, de l'agréger, ou de repérer ce qui pourrait monter au socle commun. Déclencheurs : entretien du cairn, ménage mémoire, agréger, socle commun, doublons, ce qui a vieilli, faire le tri.
---

# Entretenir le cairn

Une mémoire qui accumule devient un carcan. Ce skill est le contrepoids : il
cherche ce qu'il faut **enlever et fusionner** autant que ce qu'il faut ajouter.

**Règle absolue : ce skill PROPOSE, il n'applique jamais.** Un entretien qui
modifie la mémoire sans arbitrage humain, c'est le carcan par la porte de service.

## 1. Inventorier

Parcourir le cairn : `commun/`, chaque `_commun/`, chaque projet. Relever pour
chaque souvenir sa nature, sa portée, sa date de mise à jour et son statut.

Respecter les cloisons : **un souvenir d'un domaine ne remonte jamais dans un
autre**, et un projet en `capture: non` est ignoré.

## 2. Chercher six choses

**Les doublons et quasi-doublons.** Deux souvenirs qui disent la même chose, dans
le même projet ou dans deux projets différents. Comparer le fond, pas les mots :
la même règle formulée autrement est un doublon.

**Les candidats à la promotion.** Une chose vue dans plusieurs projets d'un même
dossier monte au `_commun/` de ce dossier. Vue dans plusieurs domaines, elle monte
à `commun/`. **Deux occurrences suffisent à proposer**, jamais à décider.

**Les périmés.** Un `fait` daté que rien n'a confirmé depuis longtemps, un
`repere` dont la cible a peut-être bougé, un chantier clos. Ne pas supposer :
signaler comme « à vérifier », et vérifier quand c'est possible.

**Les remplacés.** Une décision qu'une décision plus récente annule. La plus
ancienne passe en `statut: remplace` et pointe vers la nouvelle. **On ne la
supprime pas** : savoir pourquoi on a changé d'avis vaut souvent plus que la
décision elle-même.

**Les journaux déguisés.** Un souvenir qui décrit un état de chantier plutôt
qu'une connaissance durable, reconnaissable à ses statuts, ses dates
d'avancement et sa longueur. Il appartient au `journal.md`.

**Le débordement du socle.** `commun/regles.md` est plafonné à douze règles. S'il
déborde, ne pas proposer d'ajout : proposer une fusion ou un retrait. La
contrainte de taille est ce qui force l'arbitrage.

## 3. Chercher aussi ce qui manque

Deux vérifications qui rapportent plus qu'elles ne coûtent :

- **Des souvenirs sans pourquoi.** Ils ne peuvent être appliqués qu'aveuglément.
  Proposer de le reconstituer, ou de retirer le souvenir s'il est introuvable.
- **Des règles qui sont en fait des préférences.** Une contrainte qui souffre des
  exceptions n'est pas une règle. C'est la source numéro un de la rigidification.

## 4. Écrire les propositions

Dans `commun/propositions-JJ-MM-AAAA.md`, groupées par nature d'action, chacune
avec : le ou les fichiers concernés, ce qui est proposé, et **la raison en une
phrase**. Classer par ce qui allège le plus.

Terminer par un compte : combien de souvenirs, combien de propositions d'ajout,
de fusion, de promotion, de retrait. Un entretien qui ne propose que des ajouts
est un entretien raté.

## 5. Rendre compte, puis s'arrêter

Résumer en quelques lignes et **s'arrêter**. Attendre l'arbitrage. N'appliquer que
ce qui est explicitement retenu, et déplacer ce qui sort vers `archive/` plutôt
que de le supprimer.
