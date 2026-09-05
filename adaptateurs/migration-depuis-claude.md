# Migrer une mémoire Claude Code existante

Si vous utilisez déjà la mémoire intégrée de Claude Code, vous avez des fichiers
dans `~/.claude/projects/<slug>/memory/`, avec cet en-tête :

```yaml
---
name: un-slug
description: une ligne
metadata:
  type: user | feedback | project | reference
---
```

## Correspondance des types

| Type natif | Devient | Remarque |
|---|---|---|
| `user` | `commun/profil.md` | Fusionner en un seul fichier, pas un par trait |
| `feedback` | `regle` ou `preference` | **C'est ici que se joue l'essentiel du tri** |
| `reference` | `repere` | Correspondance directe |
| `project` | `decision`, `fait`, ou une entrée de `journal.md` | Le type le plus mélangé |

## Les deux tris qui comptent

**`feedback` vers `regle` ou `preference`.** Un feedback est une correction que
vous avez faite un jour. Certaines sont des règles absolues, la plupart sont des
préférences. Faire de chacune une règle est exactement ce qui transforme un
assistant en contrôleur au bout de quelques mois. Dans le doute, c'est une
préférence.

**`project` vers mémoire ou journal.** Un fichier `project` contient souvent
deux choses mélangées : des décisions durables (« on a choisi telle approche
parce que ») et un état de chantier (« livré le 12/03/2026, reste à faire X »).
Les décisions deviennent des souvenirs de nature `decision`. L'état part dans
`journal.md`. Un fichier `project` de quatre-vingts lignes est presque toujours
un journal déguisé.

## Procédure

1. **Ne supprimez rien avant d'avoir validé.** Faites un `git init` dans votre
   cairn dès le premier geste, tout devient réversible.
2. Créez les domaines et rangez chaque projet, avec son `contexte.md`.
3. Remontez au socle commun ce qui n'appartient à aucun projet. C'est souvent
   là que se trouvent les meilleures trouvailles : les règles d'écriture et les
   habitudes de travail sont fréquemment enfermées dans le premier projet où
   elles ont été énoncées, alors qu'elles valent partout.
4. Convertissez projet par projet, du plus petit au plus gros, pour roder la
   main avant d'attaquer le gros morceau.
5. Pour chaque fichier : classez la nature, **ajoutez le Pourquoi manquant**
   (c'est le travail le plus long et le plus utile), datez, sortez les états de
   chantier vers le journal, marquez périmé ce qui l'est.
6. Reconstruisez les index à une ligne par souvenir.
7. Faites le ménage : dossiers vides, projets renommés dont la mémoire est
   restée orpheline sous l'ancien chemin.

## À quoi s'attendre

Ce n'est pas une conversion mécanique et aucun script ne la fera à votre place :
décider qu'un souvenir est une règle ou une préférence, et retrouver le pourquoi
d'une décision prise il y a six mois, demande un humain. Comptez une bonne
séance pour un projet chargé.

En échange, c'est le moment où vous relisez tout ce que vous avez accumulé, et
où vous jetez ce qui ne sert plus. Beaucoup de la valeur de la migration est là.
