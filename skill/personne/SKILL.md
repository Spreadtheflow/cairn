---
name: personne
description: "Tenir la fiche d'une personne avec qui l'utilisateur est en relation : qui elle est au travail, et comment travailler avec elle. Crée une fiche à la seconde apparition d'un interlocuteur, l'enrichit de ce qui revient dans les échanges, et ne fait de recherche publique que sur demande, limitée au rôle professionnel. Utiliser quand un interlocuteur est nommé une seconde fois, quand l'utilisateur demande qui est quelqu'un, veut une fiche, ou donne une information sur la façon de travailler avec une personne. Déclencheurs : qui est, fiche, interlocuteur, retiens qui est, elle ne répond jamais, il préfère. En anglais : who is, contact, person, remember who."
---

# Tenir la fiche d'une personne

Redonner à chaque séance qui est qui coûte du temps, et ce qui rend une relation
fluide ne se trouve nulle part ailleurs : qui décide, qui prépare, qui ne répond
jamais le matin. Ce skill tient une fiche par interlocuteur, et **seulement pour
les interlocuteurs**.

## 1. Qui a une fiche, et qui n'en a pas

**Une fiche, c'est une personne avec qui l'utilisateur est en relation** : un
client, un collègue, un prestataire, quelqu'un avec qui il échange.

**Jamais de fiche** pour une personne qui figure dans des données qu'il traite :
les salariés d'une base auditée, les abonnés d'une newsletter, les lignes d'un
export, les auteurs cités dans un document. Ce sont des données, pas des
relations, et en faire des fiches serait du fichage.

**Le seuil est la seconde apparition.** Un nom vu une fois n'a pas de fiche : il
est noté en une ligne sous « Vus une fois » dans l'index des personnes, avec la
date et l'endroit. Vu une seconde fois, dans un échange, un document ou le
journal, l'agent crée la fiche **sans demander**, depuis ce que disent les
sources de l'utilisateur, et le dit en une ligne.

Respecter la politique du projet : en `capture: non`, rien ; en
`diffusion: publique`, pas de fiche.

## 2. Où elle vit

Dans le `_commun/personnes/` du dossier qui correspond à son organisation :
`clients/orsay-mutuelle/_commun/personnes/` pour une interlocutrice d'Orsay,
quel que soit le chantier. À défaut de groupe, dans un `personnes/` du projet.
Un fichier par personne, `prenom-nom.md`, et un `index.md` avec une ligne par
fiche.

**Ces dossiers ne se chargent pas à l'ouverture.** Quand un nom apparaît dans la
séance, regarder s'il a une fiche dans l'index des personnes du client, et
l'ouvrir alors.

## 3. Ce qu'elle contient

Depuis `gabarits/personne.md`. Deux parties, et rien d'autre.

**Au travail** : poste, organisation, rôle dans les dossiers en cours. Juste de
quoi ne pas refaire la bio. Chaque fait porte **sa source et sa date** : le
document, l'échange, la page. Un poste change : un fait daté se vérifie, un fait
sans date ment un jour sans prévenir.

**Comment travailler avec elle** : ce qui **revient** dans les échanges.
« Pas disponible le mercredi », « ne répond jamais avant 14h », « préfère un
tableau à un texte », « décide seule, fait relire par X ». On note le motif,
**jamais une cause supposée** : l'agent n'a pas à deviner pourquoi quelqu'un
n'est pas là le mercredi. Un motif vu une fois s'écrit avec « une fois, le
JJ/MM/AAAA » ; il se confirme ou disparaît.

**Ce qu'elle ne contient jamais** : la vie privée, la famille, la santé, les
opinions, les appréciations sur la personne. Rien qu'on ne pourrait lui montrer
sans gêne.

## 4. La recherche publique, sur demande seulement

Quand l'utilisateur le demande, ou propose de le faire, chercher le rôle
professionnel public : page de l'organisation, annuaire professionnel,
publications du métier. Rien d'autre.

**Vérifier l'homonymie avant d'écrire** : même organisation, même métier, même
région. Au moindre doute, ne rien écrire et le dire. Attribuer à un
interlocuteur le parcours d'un autre, c'est inventer, et ça se découvre en
réunion.

## 5. Enrichir au fil des échanges

Quand une séance apporte quelque chose sur une personne qui a déjà une fiche,
l'ajouter à la bonne partie, daté, et mettre `maj` à jour. Si un fait est
contredit, le corriger et garder l'ancien en une ligne (« DG jusqu'en mai 2026 »).
Le dire en une ligne, et continuer.

## Ce qu'il ne faut pas faire

- Créer des fiches en lot à partir d'un document.
- Faire une fiche pour une personne qui n'est qu'une donnée.
- Chercher sur le web sans que l'utilisateur l'ait demandé.
- Écrire une cause supposée, une appréciation, ou quoi que ce soit de privé.
- Recopier une fiche d'un autre outil : la fiche du cairn dit la relation, pas
  l'annuaire.
