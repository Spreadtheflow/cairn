# Exemples

Un client complet, entièrement fictif et anonymisé, pour montrer à quoi
ressemble un cairn habité.

L'exemple choisi n'est **pas** un projet de développement, volontairement : la
méthode se transpose à l'audit, au travail sur des données ou à la rédaction, et
c'est plus facile à croire en le voyant.

```
clients/
  orsay-mutuelle/           un groupe : pas de contexte.md
    _commun/                ce qui vaut pour tous ses chantiers
      fiche-client.md
    audit-conformite/       un projet : il a un contexte.md
      contexte.md
      index.md
      journal.md
      *.md                  les souvenirs, un par fichier
```

Regardez en particulier `_commun/fiche-client.md` : les contraintes de rythme du
client valent pour tous ses chantiers, elles sont donc écrites une fois au niveau
du client plutôt que recopiées dans chaque projet.
