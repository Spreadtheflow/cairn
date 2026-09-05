# Amorce, installation par l'assistant

**Ce document ne s'adresse pas à vous, il s'adresse à votre assistant.**

Si vous n'êtes pas développeur, vous n'avez rien à installer vous-même. Ouvrez
Claude Code, Codex ou l'assistant que vous venez d'installer, et collez-lui
l'adresse du projet :

> https://github.com/Spreadtheflow/cairn

Il vous proposera de l'installer. Si vous préférez être explicite : « installe
Cairn chez moi en suivant ce dépôt », avec la même adresse.

Il vous posera quelques questions sur vous et votre façon de travailler, puis
tout sera en place. Comptez dix minutes, dont huit de conversation.

**Il vous demandera l'autorisation** de créer des dossiers et d'écrire des
fichiers. C'est normal, c'est même le seul moment où vous avez quelque chose à
faire : acceptez. Un assistant qui n'a pas ces droits vous le dira au lieu de
faire semblant.

Si vous discutez avec un assistant qui n'a aucun accès à votre machine, une
simple conversation dans un navigateur par exemple, cette installation ne
s'applique pas : suivez `INSTALLATION.md` à la main, ou installez un outil qui
tourne sur votre ordinateur.

---

## À partir d'ici, ce sont des instructions pour l'assistant

Tu installes la méthode Cairn. Lis ce document en entier avant de commencer.

**Si on t'a seulement donné l'adresse du dépôt**, sans rien demander de plus : ne
te lance pas. Explique en trois lignes ce qu'est Cairn, propose de l'installer, et
attends un accord explicite. La personne est peut-être simplement en train de
regarder.

**Vérifie que tu peux écrire des fichiers sur cette machine.** Demander une
autorisation est normal et attendu ; si tu n'as réellement aucun accès, ne fais
semblant de rien : dis-le, et oriente vers `INSTALLATION.md`, qui décrit le
chemin manuel.

**La règle qui gouverne toute l'installation : tu as le droit d'utiliser le
terminal, la personne non.** Ne lui demande jamais de taper une commande, de
créer un dossier, de modifier un fichier ou d'ouvrir un éditeur. Si tu as besoin
d'un outil qu'elle n'a pas, débrouille-toi autrement.

Trois interdits absolus : **aucune commande demandant des droits
administrateur**, **aucun lien symbolique** (ils échouent sous Windows sans
réglage particulier, et ils ne servent à rien ici), **aucune modification du
PATH ou du profil de shell**.

### 1. Annonce ce que tu vas faire

En quatre lignes, avant de toucher à quoi que ce soit : tu vas créer un dossier
`cairn` dans son dossier personnel, y écrire des fichiers texte, poser un fichier
d'instructions pour l'assistant, et installer quelques raccourcis. Rien d'autre
sur la machine, rien de désinstallable difficilement.

Demande confirmation. Si elle refuse, arrête-toi.

### 2. Détermine les chemins réels

Ne suppose rien, **vérifie**.

- Le dossier personnel : `~` sous macOS et Linux, `%USERPROFILE%` sous Windows.
- Le cairn ira dans `<dossier personnel>/cairn`. S'il existe déjà, **ne le touche
  pas** : dis-le et demande quoi faire.
- Le dossier de configuration de l'assistant. Pour Claude Code, `.claude` dans le
  dossier personnel. Vérifie qu'il existe avant d'écrire dedans.

Note ces chemins, tu t'en serviras jusqu'au bout, et écris-les en clair dans ton
compte rendu final.

### 3. Récupère les fichiers de la méthode

Essaie dans cet ordre, et arrête-toi au premier qui marche :

1. `git clone https://github.com/Spreadtheflow/cairn.git` dans un dossier
   temporaire, si `git` est disponible.
2. Télécharge l'archive
   `https://github.com/Spreadtheflow/cairn/archive/refs/heads/main.zip` et
   décompresse-la, avec les outils du système (`curl` et `unzip` sous macOS,
   `Invoke-WebRequest` et `Expand-Archive` sous Windows).
3. Récupère les fichiers un par un depuis
   `https://raw.githubusercontent.com/Spreadtheflow/cairn/main/<chemin>`.

Si les trois échouent, dis-le clairement plutôt que d'inventer un contenu
approchant, et propose à la personne de télécharger l'archive à la main depuis
la page du projet, puis de te dire où elle l'a mise.

### 4. Crée le cairn

Copie dans `<dossier personnel>/cairn` :

- le contenu de `squelette/`, qui donne `commun/`, `archive/`, `pro/`, `perso/` ;
- le dossier `gabarits/` ;
- `METHODE.md`, `DOCTRINE.md` et `AIDE.md`.

Puis remplace les dates d'exemple des fichiers du socle par la date du jour, au
format JJ/MM/AAAA.

Si `git` est disponible, propose un `git init` et un premier commit dans le
cairn, en expliquant en une phrase à quoi ça sert : pouvoir revenir en arrière
si quelque chose est écrit de travers. **Propose, n'impose pas.**

### 5. Écris le profil en l'interrogeant

**C'est l'étape la plus importante, et la seule que tu ne peux pas faire seul.**
Un fichier `commun/profil.md` vide ou générique ne sert à rien ; c'est lui qui
sera lu au début de chaque session.

Mène un vrai échange, en prose, pas un questionnaire. Cinq ou six questions
suffisent, posées **en une fois** et non l'une après l'autre :

- Quel est son métier, et à quel point est-elle technique ? Une réponse honnête
  ici change tout le reste.
- Sur quoi travaille-t-elle en ce moment, et avec qui ?
- Comment décide-t-elle ? Vite, ou en creusant ?
- Qu'est-ce qui lui fait perdre son temps avec un assistant ? C'est la question
  qui rapporte le plus.
- Y a-t-il des choses qu'elle ne supporte pas dans la forme des réponses ?
  Longueur, jargon, listes, ton.
- Dans quelle langue travaille-t-elle ?

Écris le profil avec ses mots à elle, pas avec les tiens, et garde-le court, une
trentaine de lignes au plus. Relis-le-lui et corrige ce qu'elle reprend.

De ce qu'elle t'a dit, certaines choses sont des **règles absolues** : ajoute-les
à `commun/regles.md`, avec leur raison, sans dépasser douze. Le reste est une
**préférence** : un fichier séparé par préférence. En cas de doute, c'est une
préférence. Explique-lui la différence en une phrase : une règle ne souffre
aucune exception, une préférence est un défaut dont on s'écarte quand le contexte
le demande.

### 6. Pose le fichier d'instructions

Copie le bloc de la section 1 de `adaptateurs/claude-code.md` dans le fichier
d'instructions global de l'assistant :

- Claude Code : `CLAUDE.md` dans le dossier de configuration.
- Un outil qui lit un `AGENTS.md` : suis `adaptateurs/agents-md.md`.
- Un outil non couvert : le bloc est autonome, place-le là où cet outil lit ses
  instructions permanentes.

Adapte le chemin du cairn dans le bloc si ce n'est pas `~/cairn`.

**Ne pose aucun lien symbolique.** L'annexe de l'adaptateur qui en parle est
réservée aux personnes à l'aise en ligne de commande, et elle n'apporte rien
d'indispensable.

### 7. Installe les skills

Copie chaque dossier de `skill/` dans le dossier `skills/` de la configuration de
l'assistant, en le créant s'il n'existe pas. Ce sont des fichiers Markdown, une
copie suffit.

Dis-lui en trois lignes ce qu'elle vient de gagner, sans réciter la liste :
`/cairn` rattache un dossier de travail, `/cadrer` ouvre un chantier, `/relire`
vérifie avant de livrer.

### 8. Rattache un premier projet

Demande-lui sur quoi elle travaille en ce moment, et où ce dossier se trouve sur
sa machine. Si elle ne sait pas dire un chemin, propose-lui de te donner le nom
du dossier et cherche-le toi-même.

Puis joue le rituel d'ouverture décrit dans `METHODE.md` : domaine, nom, capture,
diffusion. Crée le projet, écris son `contexte.md` avec le chemin réel, et pose
le marqueur `.cairn` dans le dossier de travail.

Si elle n'a rien sous la main, saute cette étape et explique qu'il suffira de
lancer l'assistant depuis un dossier de travail : il proposera de le rattacher
tout seul.

### 9. Vérifie, puis présente

Vérifie que le profil est rempli, que le fichier d'instructions est en place,
que les skills sont présents, et que le premier projet est rattaché si tu en as
créé un.

Puis **affiche l'aide**, en suivant le skill `cairn-aide` que tu viens
d'installer : lis `AIDE.md` dans le cairn, confronte-le à ce qui existe
réellement, et présente le tout. Ne récite pas un raccourci que tu n'as pas
installé.

Termine par **une seule chose à faire**, pas une liste. Si le profil est resté
maigre, c'est celle-là. Sinon, c'est de lui dire « on s'arrête là » en fin de
prochaine séance.

Et par la phrase qui compte : elle n'a rien à faire de particulier pour que ça
serve. Elle travaille normalement, et son assistant retient ce qui mérite de
l'être. Elle peut revoir cette page à tout moment avec `/cairn-aide`.

## Ce que tu ne dois pas faire

- Lui demander de taper quoi que ce soit dans un terminal.
- Créer un lien symbolique, modifier le PATH, demander des droits administrateur.
- Écrire un profil générique parce qu'elle a répondu brièvement. Reformule ta
  question, ou écris moins mais juste.
- Remplir `commun/regles.md` de tout ce qu'elle a dit. Douze au maximum, et en
  cas de doute c'est une préférence.
- Toucher à un cairn qui existe déjà.
- Terminer sur une liste de choses à faire. Une seule.
- Expliquer la méthode. Elle n'a pas besoin de la connaître pour s'en servir.
