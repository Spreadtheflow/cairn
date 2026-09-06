---
name: cairn-aide
description: "Afficher l'aide de Cairn : comment ça marche, les raccourcis disponibles, où sont les fichiers, et l'état réel du cairn de la personne. Utiliser quand elle demande comment ça marche, ce qu'elle peut faire, quels sont les raccourcis, où est sa mémoire, ou qu'elle semble perdue avec la méthode. Sert aussi à clore une installation. Déclencheurs : aide cairn, comment ça marche, à quoi ça sert, quels raccourcis, où est ma mémoire, je suis perdu, rappelle-moi."
---

# Afficher l'aide

Ce skill présente Cairn à quelqu'un qui vient de l'installer, ou qui a oublié
comment s'en servir. Il sert aussi de dernière étape à une installation.

## 1. Lire la partie stable

Ouvrir `AIDE.md` à la racine du cairn. C'est le texte de référence, une page,
écrit pour quelqu'un qui n'est pas développeur.

S'il est absent, le récupérer depuis
`https://raw.githubusercontent.com/Spreadtheflow/cairn/main/AIDE.md` et le
déposer dans le cairn.

## 2. Calculer l'état réel

**Ne pas réciter le texte tel quel : le confronter à ce qui existe vraiment.**

- Où est le cairn, en chemin absolu.
- Quels domaines existent : les dossiers à la racine, hors `commun`, `archive` et
  `gabarits`.
- Combien de projets : le nombre de `contexte.md`.
- Le dossier courant est-il rattaché, et à quel projet.
- **Quels raccourcis sont réellement installés** : lister le dossier `skills/` de
  la configuration de l'assistant. Ne jamais annoncer un raccourci absent.
- Le profil est-il rempli, ou encore au gabarit ? S'il est vide, c'est la seule
  chose à signaler comme à faire.

## 3. Présenter

Adapter la longueur à la situation.

**Juste après une installation**, ou quand la personne est perdue : la page
entière, en gardant le ton de `AIDE.md`, avec les chiffres réels insérés là où
c'est utile. Terminer par **une seule chose à faire**, pas une liste.

**Sur une demande ponctuelle** (« c'était quoi le raccourci pour... ») : répondre
la chose demandée, et ne proposer la page entière qu'en une ligne, au cas où.

**Si le profil est vide**, c'est le seul point à insister : proposer de le
remplir tout de suite en posant les questions, parce que c'est lui qui est lu à
chaque séance et que tout le reste en dépend.

## 4. Ne pas faire

- Réciter les neuf raccourcis quand on en demande un.
- Annoncer un raccourci qui n'est pas installé.
- Expliquer la méthode. Elle est dans `METHODE.md`, et personne n'a besoin de la
  lire pour s'en servir.
- Terminer sur une liste de prochaines étapes. Une seule.
