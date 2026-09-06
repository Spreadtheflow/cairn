# Adaptateur : les autres assistants

Le principe est le même partout, et c'est tout l'intérêt de la méthode : **le
contenu ne change pas, seul l'endroit où on le colle change.** Ce document dit
où, pour chaque outil, et ce qu'il faut savoir de lui.

Tout ce qui suit a été relevé sur la documentation officielle de chaque outil
le **06/09/2026**. Ces outils bougent vite : si un chemin ne correspond plus,
c'est cette page qui est en retard, et la documentation de l'outil fait foi.

## Le bloc

Le bloc d'instructions est celui de `claude-code.md`, section 1, entre ses deux
marqueurs. Il est autonome et ne suppose rien de l'outil, sauf sa capacité à
lire des fichiers sur le disque. Collez-le tel quel, en changeant deux choses :

- le chemin du cairn, si ce n'est pas `~/cairn` ;
- la phrase sur la mémoire intégrée, qui nomme celle de Claude Code. Remplacez
  `~/.claude/projects/*/memory/` par ce que votre outil possède, voir la colonne
  « mémoire intégrée » plus bas, ou supprimez la phrase s'il n'en a pas.

Ajoutez, pour tout outil qui cloisonne l'accès au disque au dossier de travail,
cette ligne : *« Si l'accès à `~/cairn` t'est refusé, demande-le. Ne suppose
jamais que la mémoire est vide parce que tu n'as pas pu la lire. »*

## Où le coller, outil par outil

Au niveau **utilisateur**, pour qu'il vaille dans tous les projets. Le fichier
`AGENTS.md` à la racine d'un projet est lu par presque tous, mais il ne vaut que
pour ce projet.

| Outil | Fichier d'instructions global | Lit `AGENTS.md` dans un projet |
|---|---|---|
| Claude Code | `~/.claude/CLAUDE.md` | non, `CLAUDE.md` |
| OpenAI Codex (CLI, IDE) | `~/.codex/AGENTS.md` | oui |
| Gemini CLI | `~/.gemini/GEMINI.md` | seulement si `context.fileName` le liste dans `~/.gemini/settings.json` |
| Cursor | « User Rules » dans les réglages, ou `~/.cursor/rules` | oui |
| GitHub Copilot CLI | `~/.copilot/copilot-instructions.md` | oui |
| GitHub Copilot dans VS Code | fichier `.instructions.md` du profil, ou `~/.copilot/instructions/`, ou `~/.claude/CLAUDE.md` | oui |
| Windsurf, devenu Devin Desktop | `~/.codeium/windsurf/memories/global_rules.md`, 6 000 caractères au plus | oui |
| Cline | `~/.cline/rules/`, et `~/.agents/AGENTS.md` | oui |
| OpenCode | `~/.config/opencode/AGENTS.md`, à défaut `~/.claude/CLAUDE.md` | oui |
| Mistral Vibe | `~/.vibe/AGENTS.md` | oui |
| Kiro | `~/.kiro/steering/`, n'importe quel `.md`, `AGENTS.md` compris | oui |
| Aider | pas de fichier d'instructions : `~/.aider.conf.yml` avec `read:` vers le bloc et `commun/` en chemins absolus | non |

Deux remarques. Il n'existe **aucun chemin commun** à tous : un même bloc se
colle dans une dizaine d'endroits différents, et c'est la raison pour laquelle
l'installation par l'assistant vaut mieux que l'installation à la main. Et
Windsurf plafonne son fichier global : le bloc entier ne tient pas, il faut le
réduire aux sections « retrouver le projet », « avant d'écrire » et « deux
mots », et renvoyer à `METHODE.md` pour le reste.

## Les skills

Le format des skills de Cairn, un dossier par skill avec un `SKILL.md` portant
`name` et `description`, **est** le format du standard ouvert Agent Skills
(agentskills.io). Il est lu tel quel par la plupart des outils. Une seule
contrainte : le nom du dossier est le `name`, en minuscules, chiffres et tirets.

| Outil | Dossier de skills utilisateur | Lit aussi `~/.agents/skills/` |
|---|---|---|
| Claude Code | `~/.claude/skills/` | non |
| Codex | `~/.agents/skills/` | c'est le sien |
| Gemini CLI | `~/.gemini/skills/` | oui |
| Cursor | `~/.cursor/skills/` | oui, et `~/.claude/skills/` |
| Copilot CLI | `~/.copilot/skills/` | oui |
| Copilot VS Code | `~/.copilot/skills/` | oui, et `~/.claude/skills/` |
| Windsurf / Devin | `~/.codeium/windsurf/skills/` | oui, et `~/.claude/skills/` |
| Cline | `~/.cline/skills/` | non |
| OpenCode | `~/.config/opencode/skills/` | oui, et `~/.claude/skills/` |
| Mistral Vibe | `~/.vibe/skills/` | non, seulement dans un projet |
| Kiro | `~/.kiro/skills/` | non |
| Aider | aucun support | |

**`~/.agents/skills/` est le meilleur point de dépôt unique** : sept outils sur
dix le lisent. Pour Cline, Vibe, Kiro et Claude Code, une copie dans leur
dossier propre suffit. Les skills sont des fichiers Markdown : là où aucun
dossier n'existe, leur contenu se colle en instruction ou se garde ouvert à
côté.

## La mémoire intégrée de chaque outil

Deux mémoires divergent toujours. Voici ce que chaque outil possède, et ce qu'il
faut en faire.

- **Écrit de lui-même dans son fichier d'instructions.** Gemini CLI édite
  `~/.gemini/GEMINI.md` quand on lui dit « souviens-toi », sans interrupteur
  documenté. Le bloc doit lui dire explicitement de ne pas le faire.
- **Désactivée par défaut, rien à faire.** Codex (« Memories », `~/.codex/memories/`),
  Kiro CLI (base de connaissances), Gemini CLI (« Auto Memory »).
- **Activée par défaut, à couper.** Copilot Memory, côté GitHub, `/memory off`
  dans le CLI ou les réglages Copilot du profil ; l'outil « memory » de VS Code,
  réglage `chat.tools.memory.enabled` à `false` ; les « Memories » de Cursor,
  dans Settings puis Rules ; Cascade de Windsurf, `~/.codeium/windsurf/memories/`,
  sans interrupteur documenté ; Kiro Web et Crew, mémoire côté serveur.
- **Aucune.** Cline, OpenCode, Mistral Vibe, Aider.

## L'accès au disque

Presque tous les outils cloisonnent l'accès au dossier de travail et demandent
une approbation pour lire ailleurs. Le cairn est ailleurs. Selon l'outil :

Codex, lecture libre et écriture par `writable_roots` ; Gemini CLI,
`--include-directories ~/cairn` ou `context.includeDirectories` ; Cursor,
`additionalReadonlyPaths` dans `~/.cursor/sandbox.json` ; Copilot CLI,
`/add-dir ~/cairn` ; VS Code, le dossier personnel est refusé par le bac à sable
et s'ajoute dans `chat.agent.sandbox.fileSystem.*` ; Devin Local, une règle
`Read(~/cairn/**)` ; Cline, l'option « Read all files » ; OpenCode,
`external_directory` avec `~/cairn/**` ; Vibe, `--add-dir ~/cairn` ; Kiro, une
règle `fs_read` ; Aider, `read:` avec des chemins absolus.

Dans tous les cas, l'assistant doit **demander** l'accès plutôt que de conclure
que la mémoire est vide.

## Sans accès au disque

Une interface web ou mobile ne lit pas `~/cairn`. Voir `web-et-mobile.md`.

## Écrire un nouvel adaptateur

Un adaptateur doit répondre à quatre questions, et à rien d'autre :

1. Où vit la mémoire, et comment la retrouver depuis un dossier de travail ?
2. Quel format a un souvenir ?
3. Quelle politique s'applique avant d'écrire ?
4. Que ne faut-il pas retenir ?

Et trois gestes qui coûtent une ligne chacun : signer les entrées de journal du
modèle qui les écrit, consigner les retours sans les promouvoir, et ne jamais
écrire dans la mémoire intégrée de l'outil.

Si votre adaptateur fait plus d'une page, c'est que vous êtes en train de
réécrire `METHODE.md`. Pointez vers elle à la place.
