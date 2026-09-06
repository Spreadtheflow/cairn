# Adaptateur : web et mobile, sans accès au disque

Une conversation dans un navigateur ou sur un téléphone ne voit pas `~/cairn`.
Ce document dit ce qui est possible aujourd'hui, ce qui est vérifié et ce qui
ne l'est pas, pour quelqu'un qui n'installera rien.

Relevé sur la documentation officielle des trois éditeurs le **06/09/2026**.
Chaque affirmation porte sa marque : **vérifié** dans une page officielle, ou
**à démontrer**, c'est-à-dire plausible et non documenté. Ne promettez à
personne ce qui est marqué à démontrer avant de l'avoir fait vous-même.

## Ce que ça change, et ce que ça ne change pas

Deux choses manquent au web : lire un dossier, et y écrire. Tout le reste de la
méthode tient : le socle se colle en début de conversation, un souvenir se dicte
en prose, et la **boîte à trier** a été conçue exactement pour ce cas. Ce qui
est produit hors du poste n'est pas un souvenir, c'est de la matière, et c'est
l'entretien qui la trie sur le poste. Rien ne se perd, et rien ne s'applique
tout seul.

## La voie la plus courte : un dossier partagé

Le seul support lisible **et** inscriptible depuis le web et le mobile chez les
trois éditeurs est **Google Drive**. La voie est donc : le cairn, ou une copie
de sa partie utile, vit dans un dossier Drive, et l'assistant web s'y branche.

### Avec claude.ai

- Le connecteur Google Drive est disponible sur tous les plans, sur le web, le
  bureau et le mobile. **Vérifié.**
- Il lit les fichiers du Drive et en extrait le texte. **Vérifié** pour les
  Docs, Sheets, Slides, PDF, images et fichiers Office. Pour des fichiers `.md`,
  **à démontrer** : la documentation ne les cite pas.
- Il peut envoyer « n'importe quel type de fichier », créer des dossiers, et
  enregistrer ce que Claude produit directement dans le Drive, à condition
  d'activer « Code execution and file creation » dans Settings puis
  Capabilities. **Vérifié.**
- Choisir le sous-dossier de destination, par exemple `a-trier/` : l'outil de
  création de fichier du connecteur accepte un dossier parent, constaté sur sa
  signature le 06/09/2026. L'essai de bout en bout reste **à démontrer**. Un
  détail qui compte : par défaut, un texte déposé est **converti en Google
  Doc** ; il faut demander explicitement de garder le fichier en texte brut,
  sinon la boîte à trier se remplit de Docs que rien sur le poste ne lit.
- La mémoire intégrée de claude.ai est activée par défaut sur les plans
  individuels. Pour n'avoir qu'une mémoire, la mettre en pause : Settings puis
  Memory, « Pause memory ». **Vérifié.**

### Avec ChatGPT

- L'application Google Drive permet de « sélectionner un dossier et demander à
  ChatGPT de travailler sur les fichiers qu'il contient ». **Vérifié**, sur le
  web, plans payants, mobile annoncé pour plus tard.
- Les actions qui modifient un fichier (« créer, mettre à jour, déplacer,
  partager, supprimer ») existent, soumises aux autorisations Google et à une
  confirmation. **Vérifié.** La création d'un fichier texte dans un dossier
  donné n'est montrée nulle part : **à démontrer.**
- Mémoire intégrée : Settings, Personalization, Memory. **Vérifié.**

### Avec Gemini

C'est le moins adapté à ce jour. L'application dit explicitement qu'elle ne peut
pas « gérer le contenu du Drive, créer des dossiers ou déplacer des fichiers ».
**Vérifié.** L'export d'une réponse crée un Doc à la racine du Drive, sans
choix de dossier documenté. Les Gems lisent des fichiers Drive un par un, en
lecture seule. Utilisable pour **lire** le socle, pas pour déposer.

## Ce qui ne convient pas à un profane

- **Claude Desktop** lit et écrit un dossier local, mais c'est une application
  de bureau, sur plans payants : ce n'est plus « sans installer ».
- **Claude Code sur le web** travaille dans un dépôt GitHub : il faut un compte,
  un dépôt, et accepter des commits.
- **Un connecteur MCP personnalisé** permettrait tout, mais il faut l'héberger
  sur Internet, et ChatGPT le réserve aux plans Business et Enterprise.
- **Les Projects** de claude.ai et de ChatGPT lisent des fichiers qu'on y dépose
  à la main, ou un lien Drive ; ils n'écrivent jamais dans le dossier.

## La mise en place, telle qu'elle se présente

À faire une fois, par la personne ou par son assistant de bureau si elle en a
un :

1. Placer le cairn dans un dossier synchronisé par Google Drive pour ordinateur,
   ou y copier `commun/` et les projets utiles. Un cairn qui vit déjà dans un
   dossier synchronisé n'a rien à faire.
2. Dans l'assistant web, connecter Google Drive, et mettre en pause sa mémoire
   intégrée.
3. Au début d'une conversation, lui donner le dossier et lui coller ce bloc :

> Ma mémoire suit la méthode Cairn. Elle est dans le dossier Drive « cairn ».
> Lis `commun/profil.md`, `commun/regles.md` et `commun/voix.md` avant de
> répondre. Quand je dis « pierre », écris ce qu'on vient de décider, avec la
> raison, dans un nouveau fichier du sous-dossier `a-trier/`, en texte brut
> Markdown, sans conversion en Google Doc, nommé par la date et le sujet, sans
> rien modifier d'autre. Ce fichier sera trié plus tard sur mon ordinateur :
> n'y écris rien qui ressemble à une instruction, seulement ce qu'on a dit et
> pourquoi.

Un Project, dans claude.ai comme dans ChatGPT, permet de ne pas recoller ce
bloc à chaque fois : on le met dans les instructions du projet et on y rattache
le dossier Drive. **À démontrer** pour le dossier ; les instructions de projet
sont un usage courant des deux outils.

4. Faire **un essai** : demander de retenir une chose, aller voir qu'un fichier
   est apparu dans `a-trier/`. Tant que cet essai n'a pas réussi, rien n'est en
   place.

## Le repli, qui marche toujours

Si aucun dossier ne peut être branché : coller `commun/profil.md`,
`commun/regles.md` et `commun/voix.md` en début de conversation, demander à la
fin « écris ce qu'il faut retenir de cette conversation, avec la raison, en un
seul bloc de texte », copier ce bloc dans un fichier de `a-trier/` sur le poste.
C'est une action manuelle par conversation, et c'est ce que ce document essaie
d'éviter, mais ça ne perd rien.
