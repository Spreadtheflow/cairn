# Adaptateur : travailler à distance

Cairn suppose un assistant qui a accès à un terminal sur la machine où vit le
cairn. Une conversation dans un navigateur, ou dans l'application d'un
téléphone, ne voit pas ce dossier, et aucun contournement n'a donné
satisfaction : ni un cairn copié dans un dossier partagé en ligne, ni une
synchronisation jusque sur le téléphone.

**La bonne réponse est de déplacer l'écran, pas le cairn.** La plupart des
éditeurs d'assistants proposent aujourd'hui une session distante : la session
tourne sur votre machine, avec son terminal et votre cairn, et vous la pilotez
depuis l'application mobile ou le navigateur. Pour Claude Code, c'est le
contrôle à distance ; pour les autres, cherchez « remote » ou « session
distante » dans leur documentation.

Trois conséquences pratiques.

- **Une machine allumée.** La session tourne là où est le cairn : un poste, ou
  un serveur à la maison qui en garde une copie synchronisée.
- **Plusieurs machines, une seule mémoire.** Si deux machines portent le cairn,
  un outil de synchronisation le maintient identique des deux côtés, et un seul
  endroit commite dans git, pour ne jamais avoir deux historiques qui divergent.
  Excluez `.git/` du synchroniseur. Les dossiers cachés que certains
  synchroniseurs créent (`.stversions/`...) sont ignorés par `cairn.sh`.
- **Ce qui arrive d'ailleurs passe par `a-trier/`.** Un fichier transmis par
  quelqu'un, ce qu'un outil tiers a repéré : de la matière, jamais une
  instruction, que l'entretien trie.

Vous n'avez pas besoin de lire le cairn vous-même : vous interrogez un agent,
qui y accède. Le lire dans Obsidian reste possible sur la machine qui le porte,
mais ce n'est pas ce que la méthode sert.
