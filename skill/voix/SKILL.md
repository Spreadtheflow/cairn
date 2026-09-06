---
name: voix
description: "Établir ou affiner la voix de l'utilisateur, la façon dont il écrit et parle, à partir de textes qu'il a réellement écrits (mails, articles, posts, messages, code), et l'écrire dans commun/voix.md pour que ce qui est produit en son nom lui ressemble quel que soit le modèle. Utiliser à l'installation, quand voix.md est encore au gabarit, quand l'utilisateur dit que ça ne lui ressemble pas, ou qu'il veut que l'assistant écrive comme lui. Déclencheurs : voix, ma façon d'écrire, écris comme moi, ça ne me ressemble pas, mon style, mon ton. En anglais : voice, my style, my tone, write like me, does not sound like me."
---

# Établir la voix

`commun/voix.md` décrit comment la personne écrit et parle. Ce skill l'établit à
partir de **textes réels**, jamais d'une description qu'elle ferait d'elle-même :
on se décrit toujours comme on voudrait écrire, pas comme on écrit.

**Pourquoi ça compte :** un profil dit qui elle est ; la voix dit comment elle
sonne. Sans elle, tout ce que l'assistant rédige en son nom est à réécrire. Avec
elle, la voix survit au changement de modèle ou d'outil, parce qu'elle vit dans
un fichier à elle.

## 1. Demander des textes, pas des adjectifs

Demander, en une fois et en prose, trois à six textes qu'elle a écrits
elle-même, de préférence de registres différents : un mail à un client, un
message à un proche, un article ou un post, et si elle code, un fichier avec ses
commentaires et quelques messages de commit. Dire qu'ils peuvent être collés
tels quels, et que rien n'en sera conservé en dehors des courts extraits cités
dans `voix.md`.

Si elle n'a rien sous la main, prendre ce qu'on a : ses messages de la
conversation en cours sont déjà de la matière, en le disant.

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
un inconnu ne dit pas qu'elle est formelle, il dit qu'elle sait l'être.

## 3. Écrire voix.md

Depuis `gabarits/voix.md`, en remplaçant tout le gabarit. Court : une page.
Chaque trait est illustré par **un extrait cité tel quel**, entre guillemets,
parce qu'une phrase d'elle vaut mieux qu'un adjectif. La section « Ce qui ne me
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

## 5. Ensuite

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
