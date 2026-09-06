---
name: relire
description: "Passer ce qui vient d'être produit au crible avant de le livrer, avec une méthode adaptée à sa nature (code exécuté, texte relu, page regardée, données recomptées), puis une lecture de sécurité ou de conformité selon ce dont il s'agit. Utiliser avant d'annoncer qu'une tâche est terminée, avant de livrer ou de partager quelque chose, ou quand l'utilisateur demande de relire, vérifier, tester, contrôler. Déclencheurs : relire, vérifier, tester, contrôler, avant de livrer, c'est bon ?, on est prêt ?, revue avant livraison."
---

# Relire, vérifier, éprouver

Ce skill applique le point 8 de la doctrine Cairn. **Produire n'est pas livrer.**

## 1. Nommer ce qui a été produit

La méthode de vérification dépend entièrement de la nature du produit. Commencer
par la nommer, à voix haute, parce que c'est ce choix qui décide de la suite.

## 2. La passe de justesse, selon la nature

**Du code** s'exécute. Lancer le cas nominal et au moins un cas limite, lire la
sortie réelle plutôt que de la supposer. Faire tourner les tests, les linters et
les vérificateurs de types du projet. **Un test qui n'a pas tourné ne compte
pas**, et un test écrit en même temps que le code éprouve souvent la forme
supposée plutôt que la vraie : le confronter au producteur réel de la donnée.

**Un texte** se relit à froid et en entier. Chercher les affirmations qu'on ne
saurait pas sourcer, les chiffres arrivés sans provenance, les passages où la
forme a pris le pas sur le fond, et les conventions d'écriture du socle.

**Une page, une maquette, une présentation** se regarde. Rendue, à la bonne
taille, dans les conditions du destinataire. Si aucun rendu n'est possible, le
dire plutôt que de conclure sur le source.

**Un document de travail** se confronte à ce qu'il décrit : les fichiers cités
existent-ils, les noms sont-ils exacts, la structure annoncée est-elle la vraie.

**Des données** se recomptent. Vérifier les totaux, les ordres de grandeur, les
valeurs manquantes, et qu'aucun filtre n'a été appliqué en silence.

**Une configuration ou une infrastructure** se relit ligne à ligne, puis
s'éprouve sur l'effet attendu, jamais sur l'absence d'erreur au chargement.

## 3. La passe de risque, selon la nature

**Du code** appelle une lecture de sécurité : les entrées sont-elles validées, un
secret traîne-t-il en clair ou dans l'historique, un accès est-il plus large que
nécessaire, une dépendance a-t-elle été ajoutée sans raison, une erreur
révèle-t-elle trop.

**Ce qui touche à des personnes, à de l'argent ou à du droit** appelle une lecture
de conformité : ce qui est collecté est-il nécessaire, ce qui est conservé l'est-il
pour une durée justifiable, ce qui est affirmé est-il défendable, ce qui est
publié engage-t-il quelqu'un.

**Ce qui part à l'extérieur** appelle les deux, plus une relecture de ce qu'on
n'aurait pas voulu montrer : un nom, un chiffre commercial, un jugement, un
chemin de fichier révélateur.

Si le projet déclare `diffusion: publique` dans son `contexte.md`, cette dernière
lecture n'est pas optionnelle.

## 4. Rendre compte, honnêtement

Dire en clair **ce qui a été vérifié et comment**, puis **ce qui ne l'a pas été
et pourquoi**.

Une vérification partielle annoncée comme telle est utile. Une vérification
supposée est pire que pas de vérification, parce qu'elle transfère une confiance
qui n'a pas été gagnée.

Bannir « ça devrait marcher ». Soit ça a tourné, soit ça n'a pas tourné.

## 5. Ce qui en sort

Si un défaut se répète ou révèle un piège durable, proposer de l'écrire en
mémoire avec son pourquoi. Les meilleurs souvenirs d'un projet naissent d'un
défaut trouvé à la relecture.
