---
name: transmettre
description: "Préparer une copie transmissible de la mémoire d'un projet, pour un client, un collègue ou une publication, en appliquant la politique de diffusion déclarée dans contexte.md. Anonymise si le projet est public, relit le ton s'il est partagé, et refuse de sortir tel quel un projet privé. Utiliser quand l'utilisateur veut transmettre, partager, exporter ou publier la mémoire d'un projet, ou la remettre à quelqu'un. Déclencheurs : transmettre, partager la mémoire, exporter le cairn, remettre au client, passation, publier."
---

# Transmettre la mémoire d'un projet

Ce skill rend **exécutable** le champ `diffusion` de `contexte.md`, qui sans lui
n'est qu'une déclaration.

**Règle de sécurité, avant tout le reste : on ne modifie jamais le cairn.** On
produit une copie, dans un dossier que l'utilisateur nomme, hors du cairn.

## 1. Lire la politique et la confronter à la destination

Ouvrir le `contexte.md` du projet et demander **à qui** ça va. Puis confronter :

- **`diffusion: privee`** et une destination extérieure : il y a contradiction.
  Ne pas exporter en silence. Dire que le projet a été écrit pour rester chez
  soi, donc qu'il contient probablement des jugements, des noms et des chiffres
  écrits sans retenue. Deux issues possibles, à faire trancher : changer la
  politique du projet et relire tout, ou produire un export réduit à ce qui est
  explicitement retenu, pièce par pièce.
- **`diffusion: partagee`** : le contenu sort en clair, mais il faut une passe de
  ton (étape 3).
- **`diffusion: publique`** : le contenu sort anonymisé (étape 4).

## 2. Choisir ce qui part

Par défaut, ce qui se transmet est ce qui **sert à quelqu'un qui reprend** : le
`contexte.md`, les souvenirs de nature `decision`, `regle` et `preference`, et
les `fait` et `repere` encore valides.

Ne partent pas par défaut, sauf demande explicite :

- le `journal.md`, qui est une chronologie interne et contient des hésitations ;
- les souvenirs en `statut: perime` ou `remplace` ;
- le contenu du `commun/` du cairn, qui décrit **la personne**, pas le projet ;
- les `_commun/` des dossiers parents, sauf si le destinataire reprend l'ensemble
  du client.

Annoncer cette sélection avant de l'appliquer.

## 3. La passe de ton, pour un partage

Relire chaque pièce en se posant une seule question : **est-ce que je dirais ça
devant la personne qui va le lire ?**

Chercher en particulier les jugements sur des décisions, sur une équipe ou sur
un prestataire, les formulations de lassitude, les raccourcis qui seraient lus
comme du mépris, et les chiffres commerciaux qui ne regardent pas le lecteur.

Reformuler plutôt que supprimer quand le fond est utile : un constat technique
reste, l'agacement qui l'accompagnait part.

## 4. L'anonymisation, pour une publication

Remplacer les noms de personnes, d'organisations, de clients, les identifiants,
les domaines, les chemins de fichiers révélateurs, et les montants.

Deux principes qui font la différence entre une anonymisation utile et une
anonymisation inutilisable :

- **Remplacer par un substitut stable**, pas par un blanc : « le client » ou un
  nom d'emprunt cohérent d'un bout à l'autre. Un texte troué ne se lit pas.
- **Garder la forme du problème.** L'intérêt d'un souvenir publié est la
  mécanique, pas l'identité. « Un organisme dissous en 2021 est apparu comme
  autorité en exercice » vaut mieux que le nom de l'organisme.

**La table de correspondance ne sort jamais.** Elle reste dans le `contexte.md`
du projet, du côté privé.

## 5. Vérifier avant de rendre

Repasser sur la copie produite, comme le ferait `/relire` :

- aucune valeur de secret, aucun jeton, aucun mot de passe ;
- aucun nom ou montant oublié par l'anonymisation, en relisant réellement plutôt
  qu'en se fiant à un chercher-remplacer ;
- les liens `[[...]]` pointent vers des fichiers présents dans l'export, ou sont
  retirés ;
- l'ensemble se lit sans le reste du cairn.

## 6. Rendre compte

Livrer trois listes : ce qui part, ce qui a été retiré, ce qui a été reformulé.
**Ce qui est retiré est compté et nommé, jamais écarté en silence** : c'est ce
qui permet à l'utilisateur de contester un retrait.

Ajouter au dossier exporté un court fichier d'accueil qui dit ce qu'est cet
export, de quand il date, et qu'il s'agit d'une copie figée, pas d'une mémoire
vivante.

## Ce qu'il ne faut pas faire

- Modifier, déplacer ou nettoyer quoi que ce soit dans le cairn d'origine.
- Exporter un projet en `diffusion: privee` sans l'avoir signalé.
- Faire confiance à un chercher-remplacer pour anonymiser.
- Emporter le socle `commun/`, qui décrit une personne et pas un projet.
