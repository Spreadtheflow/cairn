---
name: cadrer
description: "Ouvrir un chantier en cadrant avant de produire. Conduit un échange en prose pour comprendre le besoin, met les tensions sur la table, recommande, puis découpe en phases avec un livrable par phase. Utiliser quand l'utilisateur veut démarrer un projet, un module ou une refonte, quand une demande est vague ou grosse, ou quand il dit cadrer, réfléchir ensemble, avant de coder, on en parle. Déclencheurs : cadrer, nouveau chantier, on démarre, avant de produire, plan, découper en phases. En anglais : scope, plan, before coding, new project, break into phases."
---

# Cadrer avant de produire

Ce skill applique le point 1 de la doctrine Cairn. Il produit un **cadrage**, pas
du travail. Rien n'est fabriqué ici.

## D'abord, aller chercher ce qui existe

Avant de poser la moindre question, lire ce qui est déjà connu, dans cet ordre :

1. Le socle `commun/` du cairn : profil, règles, préférences.
2. Le `contexte.md` et l'`index.md` du projet, s'il est déjà rattaché.
3. Les mémoires de nature `decision` du projet et de son `_commun`.

**Ce qui a déjà été arbitré ne se re-litige pas.** Si une décision existante
contredit ce qui est demandé, le dire tout de suite, avec sa date et sa raison, et
demander si elle est rouverte. C'est une question, pas un refus.

## Conduire l'échange en prose

Pas de questionnaire à choix multiples : une liste d'options ferme le sujet, une
conversation l'ouvre. Les choix fermés arrivent naturellement plus tard.

La forme qui marche, dans cet ordre :

1. **Reformuler ce qu'on a compris**, en quelques phrases, y compris ce qu'on
   croit avoir compris de travers.
2. **Aller vérifier le terrain** plutôt que de le supposer : lire le code, les
   fichiers, la structure réelle. Un cadrage bâti sur une supposition se paie
   deux fois.
3. **Mettre les tensions sur la table.** Ce qui s'oppose, ce qui coûte cher, ce
   qui est irréversible. Nommer ce qu'on ne sait pas.
4. **Recommander clairement**, en une phrase par arbitrage : « mon penchant est
   X, parce que Y ». Pas un catalogue d'options équivalentes.
5. **Regrouper les questions ouvertes en fin de message.** N'interrompre en cours
   de route que sur un blocage dur, c'est-à-dire quand continuer sous une
   hypothèse rendrait le travail inutilisable si elle est fausse.

Laisser de la place : si la personne part ailleurs, suivre et voir où ça mène.

## Découper

Ce qui est trop gros se découpe en phases. **Une phase qu'on ne sait pas décrire
en une ligne est une phase mal découpée.** Chaque phase porte un livrable, et le
livrable de la première doit être utile seul.

Ordonner par ce qui **lève une incertitude**, pas par ce qui est facile. La phase
qui apprend quelque chose passe avant celle qui produit du volume.

## Clore le cadrage

Terminer par un plan écrit qui contient : le contexte et pourquoi maintenant, ce
qui est décidé, ce qui reste ouvert, les phases avec leur livrable, et comment on
vérifiera que ça marche.

Puis **s'arrêter** et demander validation. Un cadrage qui glisse en production
n'est plus un cadrage.

Quand les décisions sont validées, proposer de les écrire en mémoire, avec leur
pourquoi.

## Ce qu'il ne faut pas faire

- Produire du code, des fichiers ou une maquette pendant le cadrage.
- Présenter trois options équivalentes sans recommander.
- Poser des questions dont la réponse est lisible dans le projet.
- Rouvrir en silence une décision déjà arbitrée.
