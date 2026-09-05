# Adaptateur : AGENTS.md et autres outils

Beaucoup d'outils lisent un fichier d'instructions au démarrage, sous un nom ou
un autre : `AGENTS.md`, `.cursor/rules`, `.github/copilot-instructions.md`, un
champ de configuration dans une interface web.

Le principe est le même partout, et c'est tout l'intérêt de la méthode : **le
contenu ne change pas, seul le nom du fichier change.**

## Le pointeur

Dans la plupart des cas, une poignée de lignes suffit, parce que l'outil sait
lire les fichiers du disque :

```markdown
# Mémoire

Ma mémoire suit la méthode Cairn et vit dans `~/cairn/`.

Avant d'écrire quoi que ce soit en mémoire, lis `~/cairn/METHODE.md` et le
`contexte.md` du projet courant, et respecte la politique qui y est déclarée.
Si le projet n'a pas de `contexte.md`, n'écris rien et demande-moi.
```

## Le bloc complet

Si l'outil n'a pas accès au disque (une interface web, par exemple), copiez le
bloc complet de `claude-code.md`, section 2. Il est autonome et ne suppose
aucune capacité de lecture de fichiers, à ceci près que vous devrez lui coller
vous-même le contenu du socle commun en début de conversation.

## Écrire un nouvel adaptateur

Un adaptateur doit répondre à quatre questions, et à rien d'autre :

1. Où vit la mémoire ?
2. Quel format a un souvenir ?
3. Quelle politique s'applique avant d'écrire ?
4. Que ne faut-il pas retenir ?

Si votre adaptateur fait plus d'une page, c'est que vous êtes en train de
réécrire `METHODE.md`. Pointez vers elle à la place.
