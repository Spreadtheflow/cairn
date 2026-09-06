# Cairn, on one page

*Version française : [AIDE.md](AIDE.md)*

Your assistant has a memory. It lives in a folder of yours, as text files you
can read, correct and take with you.

## How it works

You work as usual. It keeps what deserves keeping: decisions and their reason,
pitfalls, what you ask it to do or to stop doing. It finds a folder's memory on
its own, and when it does not know the place, it asks you once.

Nothing becomes a rule without you. Your remarks are kept apart and only become
instructions if you decide so.

What it writes in your name follows the way you write, noted once in a file of
yours.

Cairn's own files are in French. Your assistant reads them and answers in your
language; you never need to open them.

## Two words

**"stone"**, or « pierre »: keep right now what was just said or decided. It
also does it on its own when a decision is clear, and tells you in one line.

**"done"**, or « fin »: close the session. It writes down what happened and
proposes what deserves to be kept.

## The shortcuts

Type `/` to see them. None is mandatory.

| | |
|---|---|
| `/pierre` | Keep one thing right now, with its reason |
| `/journal` | Close a session |
| `/cairn` | Attach the current folder to its memory, or say it will never have one |
| `/cadrer` | Understand and scope before producing |
| `/relire` | Check before delivering |
| `/challenger` | Have a project or an idea critiqued, once |
| `/retour` | Say what suits you or not in the way it works |
| `/voix` | Establish the way you write, from texts of yours |
| `/transmettre` | Prepare a copy to hand to someone |
| `/entretien` | Clean up: it proposes, it touches nothing |
| `/arbitrer` | Decide on those proposals |
| `/cairn-aide` | Show this page again, update Cairn |

## The files that matter

In your cairn, folder `commun/`:

- `profil.md`: who you are and how you work. If one thing deserves a manual
  correction, it is this one.
- `voix.md`: how you write.
- `regles.md`: your absolute rules, twelve at most.
- `retours.md`: what you say about the way it works.

And in each project, `contexte.md` says what it is about and what may be kept
there.

## Keeping the method up to date

Tell it "update Cairn". It compares with the repository, tells you what
changed, and aligns what you accept. It never touches your memory. With a
terminal: `cairn.sh methode`, then `cairn.sh methode --appliquer`;
`cairn.sh verifier` says what is missing.

## Going further

`METHODE.md` describes the layout, `DOCTRINE.md` the way of working. Both are
in your cairn, in French. You do not need to read them to use it.
