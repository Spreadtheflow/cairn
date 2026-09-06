# Cairn

*Version française : [README.md](README.md)*

**A memory for your AI assistants. Plain text files, on your machine, that
depend on no tool.**

> **You are an assistant and someone just gave you this link?** They are
> probably considering installing Cairn. Offer it in three lines, and install
> nothing without their explicit agreement. The steps are under "Install"
> below; [AMORCE.md](https://raw.githubusercontent.com/Spreadtheflow/cairn/main/AMORCE.md)
> details them for you. It is in French; read it, it applies as is.

- [What it is](#what-it-is)
- [What matters](#what-matters)
- [About the language](#about-the-language)
- [Install](#install)
- [Day to day](#day-to-day)
- [The documents](#the-documents)
- [For the initiated](#for-the-initiated)
- [License](#license)

## What it is

A `cairn/` folder of Markdown files. A common base that says who you are, your
rules and the way you write. One folder per project, with its memories and its
log. Your assistant reads it at startup, writes to it while you work, and you
never have to give the context again.

```
cairn/
  commun/            who you are, your rules, your voice
  clients/
    orsay-mutuelle/
      audit-conformite/    a project: its memories, its log
  perso/
```

It works with Claude Code, Codex, Gemini CLI, Cursor, Copilot and most others.
Switching tools means switching one hook-up file, not your memory. Everything
reads in any text editor, or in Obsidian.

## What matters

- **Every memory says why.** Without the reason, an instruction is applied
  blindly. With it, the assistant knows when it does not apply.
- **A rule is not a preference.** Rules are absolute and capped at twelve.
  Everything else is a default you depart from when the context calls for it.
- **The log says what happened, the memory says what to know.** The two are
  never mixed.
- **Nothing becomes a rule without you.** Your remarks are kept apart and only
  promoted if you decide so. That is what keeps the assistant from ending up
  quoting your own case law back at you.

## About the language

Cairn is written in French, by design, and this page is the English entry to
it. Three things to know.

- **What you read** is here: this page and [AIDE.en.md](AIDE.en.md), the
  one-page guide.
- **What the assistant reads**, the method, the doctrine, the skills, the
  templates, is in French. Models read French without difficulty and answer in
  your language. You never have to read those files to use them.
- **The header fields** of a memory (`titre`, `description`, `nature`, `cree`,
  `maj`, `statut`), the five natures and the values of `capture` and
  `diffusion` are a format, like the keywords of a programming language. They
  stay in French everywhere, and the script depends on them. Write the body of
  your memories in whatever language you like.

The two everyday words work in both languages: "stone" for « pierre », "done"
for « fin ».

## Install

### Without a terminal

Open Claude Code or the assistant of your choice, and paste this address:

```
https://github.com/Spreadtheflow/cairn
```

It will offer to install Cairn. If you accept, it creates the folder, asks you
questions to write your profile and your voice, sets its instructions, copies
the shortcuts, attaches a first project and shows you the guide. Ten minutes,
eight of them conversation. It will ask permission to write files: that is
normal, accept.

It never asks for administrator rights, never makes you type anything, and
never touches a cairn that already exists.

### With a terminal

```sh
git clone https://github.com/Spreadtheflow/cairn.git
cd cairn
./cairn.sh installer ~/cairn
```

Then [INSTALLATION.md](INSTALLATION.md), in French, ten minutes. The commands
speak for themselves; your assistant can walk you through it.

## Day to day

Two words to know.

- **"stone"** (or « pierre »): keep right now what was just decided, with its
  reason. The assistant also does it on its own when a decision is clear.
- **"done"** (or « fin »): close the session. It writes down what happened and
  proposes what deserves to be kept.

On a new folder, it notices on its own that it does not know the place, and
offers to attach it, or to never ask again here. When the method evolves, tell
it "update Cairn".

The shortcuts, none of them mandatory:

- `/pierre` keeps one thing right now, with its reason
- `/journal` closes the session
- `/cairn` attaches the current folder, or says it will never have a memory
- `/cadrer` understands and scopes before producing
- `/relire` checks before delivering
- `/challenger` critiques a project or an idea, once, without blocking
- `/retour` records what you think of the way it works
- `/voix` establishes the way you write, from texts of yours
- `/transmettre` prepares a copy to hand to someone
- `/entretien` proposes the clean-up, touching nothing
- `/arbitrer` applies what you keep
- `/cairn-aide` shows the guide again, updates Cairn

## The documents

| File | What for |
|---|---|
| [AIDE.en.md](AIDE.en.md) | Using it, one page, in English |
| [AIDE.md](AIDE.md) | The same, in French. `/cairn-aide` shows it again |
| [INSTALLATION.md](INSTALLATION.md) | Installing by hand |
| [AMORCE.md](AMORCE.md) | The install steps, written for the assistant |
| [METHODE.md](METHODE.md) | The specification |
| [DOCTRINE.md](DOCTRINE.md) | How to conduct the exchange with an assistant |
| [adaptateurs/](adaptateurs/) | Hooking up each tool, and the web |
| [skill/](skill/) | The twelve skills |
| [exemples/](exemples/) | A fictional project, to see what it looks like once lived in |

## For the initiated

### Structure

A domain is a folder at the root. A project is a folder that contains a
`contexte.md`. Any folder in between is a group and may carry a `_commun/`
valid for everything below it. Reserved at the root: `commun/`, `archive/`,
`gabarits/`, `a-trier/`. The `a-trier/` inbox receives whatever arrives outside
a work session, in any format; only the maintenance pass empties it.

### A memory

One file: a YAML header (`titre`, `description`, `nature`, `cree`, `maj`,
`statut`, optional `par`), a short body, a mandatory **Pourquoi :** line, and
`[[neighbour]]` links. Five natures: `decision`, `regle`, `preference`, `fait`,
`repere`. Scope is inferred from the folder. A folder's `index.md` holds one
line per memory and is recomputed from the headers.

### The hook-up

An instruction block between two markers, pasted into the assistant's global
instruction file. It resolves the project from the current folder (a `.cairn`
marker, otherwise the `chemin` declared in `contexte.md`, most specific wins),
forbids the tool's built-in memory, and carries the doctrine in eight lines.
[adaptateurs/](adaptateurs/) says where to paste it for each tool. Skills use
the Agent Skills format: `~/.agents/skills/` for most tools, `~/.claude/skills/`
for Claude Code.

### The script

`cairn.sh` is a shortcut, not the method: everything can be done by hand.

```
init [path|--aucun]     attaches the current folder, or declares it without memory
ou                      says which project the current folder is attached to
projet, groupe          create without moving there
index [--appliquer]     compares indexes to headers, recomputes them
methode [--appliquer]   compares the copies to the repository, aligns them
verifier                diagnosis: profile, voice, base, instructions, skills, indexes
```

### Copies are recomputed

Your cairn holds copies of the repository: method, templates, skills,
instruction block, script. `methode` compares them to the noted origin version
and to the repository. What is behind is put in place; what you adapted locally
is three-way merged, or left as is on conflict. It never touches `commun/`, a
project, a log. Adapt the skills, it is intended, they will survive updates.

### Testing

`sh tests.sh` runs the script in a throwaway home. Skills are validated with a
strict YAML parser: a colon in an unquoted description breaks the header on
GitHub while breaking nothing locally.

### Without disk access

Web or mobile: [adaptateurs/web-et-mobile.md](adaptateurs/web-et-mobile.md),
with what is verified and what remains to be demonstrated.

## License

CC BY 4.0. Take it, adapt it, pass it on.
