---
name: voix
description: "Établir ou affiner la voix de l'utilisateur, la façon dont il écrit et parle, avec ses facettes familière et pro, à partir de textes qu'il a réellement écrits (mails, articles, messages, code, et ses propres messages en séance), et l'écrire dans commun/voix.md pour que ce qui est produit en son nom lui ressemble quel que soit le modèle. Sert aussi à verser dans voix.md les observations mûres de commun/observations.md. Utiliser à l'installation, quand voix.md est encore au gabarit, quand l'utilisateur dit que ça ne lui ressemble pas, ou qu'il veut que l'assistant écrive comme lui. Déclencheurs : voix, ma façon d'écrire, écris comme moi, ça ne me ressemble pas, mon style, mon ton. En anglais : voice, my style, my tone, write like me, does not sound like me."
---

# Établir la voix

`commun/voix.md` décrit comment la personne écrit et parle. Ce skill l'établit à
partir de **textes réels**, jamais d'une description qu'elle ferait d'elle-même :
on se décrit toujours comme on voudrait écrire, pas comme on écrit.

**Pourquoi ça compte :** un profil dit qui elle est ; la voix dit comment elle
sonne. Sans elle, tout ce que l'assistant rédige en son nom est à réécrire. Avec
elle, la voix survit au changement de modèle ou d'outil, parce qu'elle vit dans
un fichier à elle.

## 1. Aller chercher la matière, puis demander ce qui manque

Avec un terminal, l'agent n'a pas à donner des devoirs : il cherche d'abord
lui-même, et ne demande que ce qu'il ne peut pas trouver.

- **Ses messages en séance.** Les transcriptions de l'outil (pour Claude Code,
  `~/.claude/projects/*/*.jsonl`, messages de type `user`) contiennent ce
  qu'elle a tapé sans y penser : c'est la matière la plus honnête, et c'est la
  **facette familière**. Écarter ce qu'elle a collé (documents, journaux, code) :
  seul ce qu'elle a écrit compte.
- **Les citations de `commun/retours.md`**, qui sont ses mots exacts.
- **Ce qu'elle a écrit seule ailleurs** : messages de commit dont elle est
  l'unique autrice (pas ceux cosignés par un assistant), documentation de ses
  dépôts. Vérifier l'auteur avant de s'en servir.

Puis demander, en une fois et en prose, ce qui manque presque toujours : un ou
deux textes de la **facette pro**, un mail à un client, un livrable qu'elle a
rédigé elle-même. Dire que rien n'en sera conservé en dehors des courts extraits
cités.

Un corpus qu'elle choisit décrit la voix qu'elle aimerait avoir ; ce qu'elle
écrit sans y penser dit celle qu'elle a. Il faut les deux, et savoir lequel est
lequel.

Ne pas demander « comment décririez-vous votre style ». La question est
inutile, et sa réponse est fausse.

## 2. Observer

Lire l'ensemble avant d'écrire une ligne. Chercher ce qui **revient**, pas ce
qui frappe une fois :

- le registre, et comment il change selon le destinataire ;
- la longueur des phrases, leur rythme, les enchaînements ;
- les ouvertures et les fermetures de message ;
- les mots qui reviennent, les tournures, les anglicismes gardés ou évités ;
- la forme : prose ou listes, titres, gras, ponctuation, emojis ;
- en code : langue des identifiants et des commentaires, ce qui est commenté et
  ce qui ne l'est pas, le style des messages de commit ;
- ce qu'on **ne trouve pas** : les formules toutes faites qu'elle n'emploie
  jamais, et qu'un assistant emploierait à sa place.

Distinguer ce qui vient d'elle de ce qui vient du contexte : un mail formel à
un inconnu ne dit pas qu'elle est formelle, il dit qu'elle sait l'être. C'est ce
qui sépare la base des facettes : la base est ce qu'on retrouve partout, une
facette ne dit que ce qui change avec la relation.

Relever à part **ce qui s'observe mais ne s'imite pas** : les coquilles de
frappe rapide, les fautes qui reviennent. Elles aident à reconnaître son
écriture, elles ne se reproduisent jamais.

## 3. Écrire voix.md

Depuis `gabarits/voix.md`, en remplaçant tout le gabarit. Court : une page.
Chaque trait est illustré par **un extrait cité tel quel**, entre guillemets,
parce qu'une phrase d'elle vaut mieux qu'un adjectif, et dit d'où il vient :
(chat), (mail), (livrable), (code). Une facette dont on n'a pas de matière reste
vide et le dit : mieux vaut « à établir » qu'une facette inventée. La section « Ce qui ne me
ressemble pas » est la plus utile : c'est la liste de ce que l'assistant ferait
spontanément et qu'il ne doit pas faire.

Le **Pourquoi** est déjà dans le gabarit ; le garder.

Ne rien écrire qui relève du profil (métier, façon de décider) : c'est
`profil.md`. Ne rien écrire qui relève d'une règle absolue : c'est `regles.md`,
et ça passe par un arbitrage.

## 4. Relire ensemble

Lui montrer le fichier, et lui demander ce qui sonne faux. Corriger avec ses
mots. Une voix mal établie est pire qu'une voix absente : l'assistant imitera
avec assurance quelqu'un qui n'existe pas.

## 5. Affiner avec le temps

La voix n'est jamais finie. À chaque « fin », le skill `journal` note au plus
deux observations dans `commun/observations.md`. Quand l'entretien signale un
motif vu dans deux séances, ou quand elle dit « ça ne me ressemble pas », rouvrir
ce skill : lire les observations, lui présenter ce qu'elles suggèrent, verser
dans `voix.md` ce qu'elle retient, avec la citation, et retirer du tampon ce qui
a été tranché, retenu ou non.

La rédaction pour un lecteur n'est pas la voix : elle vit dans
`commun/redaction.md` et se nourrit des corrections. Ne pas la mélanger ici.

## 6. Ensuite

La voix s'applique dès que l'assistant rédige quelque chose qui sera lu comme
venant d'elle. Elle ne s'applique pas aux échanges de travail entre elle et
l'assistant. Quand elle dit « ça ne me ressemble pas » sur un texte produit,
c'est le signal pour rouvrir ce skill et affiner, avec le texte fautif comme
contre-exemple.

## Ce qu'il ne faut pas faire

- Écrire la voix d'après ce qu'elle dit d'elle-même.
- Conserver les textes collés ailleurs que dans les extraits de `voix.md`.
- Généraliser depuis un seul texte, ou depuis un seul registre.
- Remplir le fichier d'adjectifs sans extraits.
- Appliquer la voix aux échanges de travail : elle est pour ce qui sort, pas
  pour ce qui se discute.
