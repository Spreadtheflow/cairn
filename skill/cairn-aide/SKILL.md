---
name: cairn-aide
description: "Afficher l'aide de Cairn : comment ça marche, les raccourcis disponibles, où sont les fichiers, l'état réel du cairn de la personne, et mettre la méthode à jour depuis le dépôt quand elle a pris du retard. Utiliser quand elle demande comment ça marche, ce qu'elle peut faire, quels sont les raccourcis, où est sa mémoire, si Cairn est à jour, ou qu'elle semble perdue avec la méthode. Sert aussi à clore une installation. Déclencheurs : aide cairn, comment ça marche, à quoi ça sert, quels raccourcis, où est ma mémoire, je suis perdu, rappelle-moi, mets Cairn à jour, mise à jour de Cairn. En anglais : help, how does it work, update Cairn."
---

# Afficher l'aide

Ce skill présente Cairn à quelqu'un qui vient de l'installer, ou qui a oublié
comment s'en servir. Il sert aussi de dernière étape à une installation.

## 1. Lire la partie stable

Ouvrir `AIDE.md` à la racine du cairn. C'est le texte de référence, une page,
écrit pour quelqu'un qui n'est pas développeur. Si la personne parle anglais,
`AIDE.en.md` dit la même chose dans sa langue.

S'il est absent, le récupérer depuis
`https://raw.githubusercontent.com/Spreadtheflow/cairn/main/AIDE.md` et le
déposer dans le cairn.

## 2. Calculer l'état réel

**Ne pas réciter le texte tel quel : le confronter à ce qui existe vraiment.**

- Où est le cairn, en chemin absolu.
- Quels domaines existent : les dossiers à la racine, hors `commun`, `archive`,
  `gabarits` et `a-trier`.
- Combien de projets : le nombre de `contexte.md`.
- Le dossier courant est-il rattaché, et à quel projet.
- **Quels raccourcis sont réellement installés** : lister le dossier `skills/` de
  la configuration de l'assistant. Ne jamais annoncer un raccourci absent.
- Le profil est-il rempli, ou encore au gabarit ? S'il est vide, c'est la seule
  chose à signaler comme à faire. La voix, `commun/voix.md`, vient juste après.
- La méthode installée est-elle à jour ? Voir la section 4.

Si `cairn.sh` est disponible, `cairn.sh verifier` fait tout ce calcul en une
commande : l'utiliser plutôt que de refaire à la main.

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

## 4. Mettre la méthode à jour

Le cairn contient des copies du dépôt de la méthode : `METHODE.md`,
`DOCTRINE.md`, `AIDE.md`, les gabarits, les skills, le bloc d'instructions de
l'assistant entre ses marqueurs `<!-- cairn:debut -->` et `<!-- cairn:fin -->`.
Le dépôt évolue, ces copies non. Quand la personne demande si Cairn est à jour,
ou de le mettre à jour, c'est l'assistant qui le fait, sans lui faire taper
quoi que ce soit.

**Avec le script**, c'est une commande : `cairn.sh methode` compare, et
`cairn.sh methode --appliquer` aligne. Ce qui a été adapté sur place est
fusionné depuis sa version d'origine, et laissé tel quel en cas de conflit.

**Sans le script**, faire la même chose à la main :

1. Récupérer le dépôt, `git clone` dans un dossier temporaire si git existe,
   sinon l'archive `https://github.com/Spreadtheflow/cairn/archive/refs/heads/main.zip`,
   sinon fichier par fichier depuis `https://raw.githubusercontent.com/Spreadtheflow/cairn/main/`.
2. Comparer chaque copie à sa source : `METHODE.md`, `DOCTRINE.md`, `AIDE.md`
   et `gabarits/*.md` à la racine du cairn ; chaque `skill/*/SKILL.md` avec le
   dossier de skills de l'assistant ; le bloc entre les deux marqueurs du fichier
   d'instructions avec celui de `adaptateurs/claude-code.md`.
3. Dire ce qui diffère, en distinguant ce qui est simplement en retard de ce qui
   a été modifié sur place. **Ne rien écraser qui a été modifié sur place** sans
   le montrer et demander.
4. Sur accord, recopier ce qui est en retard, poser ce qui est absent, et
   remplacer le bloc d'instructions entre ses marqueurs sans toucher au reste du
   fichier.

**Jamais** `commun/`, un projet, un journal, un `contexte.md` : ces fichiers
n'ont pas de source ailleurs, ils sont la mémoire.

## 5. Ne pas faire

- Réciter tous les raccourcis quand on en demande un.
- Annoncer un raccourci qui n'est pas installé.
- Expliquer la méthode. Elle est dans `METHODE.md`, et personne n'a besoin de la
  lire pour s'en servir.
- Terminer sur une liste de prochaines étapes. Une seule.
