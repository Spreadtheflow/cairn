#!/bin/sh
# Banc de test de cairn.sh. Tout se joue dans un dossier temporaire : un dépôt
# de la méthode copié depuis ce dossier de travail, un foyer vierge, un cairn
# installé dedans. Rien n'est touché hors de ce dossier.
#
#   sh tests.sh            joue tout
#   sh tests.sh -v         affiche aussi la sortie des commandes

set -u

ICI=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
VERBEUX=0; [ "${1:-}" = "-v" ] && VERBEUX=1
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT INT TERM

# Le dépôt de la méthode : une copie du dossier de travail, commitée.
DEPOT=$T/depot
mkdir -p "$DEPOT"
( cd "$ICI" && find . -path ./.git -prune -o -type f -print | while IFS= read -r f; do
    mkdir -p "$DEPOT/$(dirname "$f")"; cp "$f" "$DEPOT/$f"; done )
git -C "$DEPOT" init -q
git -C "$DEPOT" -c user.name=test -c user.email=test@test config commit.gpgsign false
git -C "$DEPOT" add -A
git -C "$DEPOT" -c user.name=test -c user.email=test@test commit -q -m "Point de départ"

# Le foyer vierge.
export HOME=$T/home
export XDG_CACHE_HOME=$HOME/.cache XDG_STATE_HOME=$HOME/.local/state
export CAIRN=$HOME/cairn
export CAIRN_DEPOT=$DEPOT
export CAIRN_SKILLS=$HOME/.claude/skills
export CAIRN_INSTRUCTIONS=$HOME/.claude/CLAUDE.md
mkdir -p "$HOME"
S=$DEPOT/cairn.sh
AUJOURDHUI=$(date +%d/%m/%Y)

commit_depot() {
    git -C "$DEPOT" add -A
    git -C "$DEPOT" -c user.name=test -c user.email=test@test commit -q -m "$1"
}

reussis=0; rates=0
SORTIE=$T/sortie
# Joue une commande, garde sa sortie et son code dans $CODE.
joue() {
    "$@" > "$SORTIE" 2>&1 < /dev/null; CODE=$?
    [ "$VERBEUX" = 1 ] && { echo "--- $*"; cat "$SORTIE"; }
    return 0
}
# Joue une commande en lui donnant des réponses sur l'entrée standard.
joue_avec() {
    reponses=$1; shift
    printf '%b' "$reponses" | "$@" > "$SORTIE" 2>&1; CODE=$?
    [ "$VERBEUX" = 1 ] && { echo "--- $*"; cat "$SORTIE"; }
    return 0
}
ok()  { reussis=$((reussis+1)); echo "  ok    $1"; }
ko()  { rates=$((rates+1)); echo "  RATÉ  $1"; [ "$VERBEUX" = 1 ] || { echo "        sortie :"; sed 's/^/        | /' "$SORTIE"; }; }
verifie() { if eval "$2"; then ok "$1"; else ko "$1"; fi; }
sortie_contient() { grep -q -- "$1" "$SORTIE"; }
fichier_contient() { [ -f "$1" ] && grep -qF -- "$2" "$1"; }

echo
echo "installer"
joue "$S" installer
verifie "crée le cairn"                       '[ -f "$CAIRN/METHODE.md" ] && [ -f "$CAIRN/commun/profil.md" ] && [ -d "$CAIRN/a-trier" ]'
verifie "copie les gabarits, dont la voix"    '[ -f "$CAIRN/gabarits/voix.md" ] && [ -f "$CAIRN/commun/voix.md" ]'
verifie "date le socle du jour"               'fichier_contient "$CAIRN/commun/profil.md" "cree: $AUJOURDHUI"'
verifie "note la version d'origine"           '[ -f "$XDG_STATE_HOME/cairn/methode-source" ]'
joue "$S" installer
verifie "refuse d'écraser un cairn existant"  '[ "$CODE" != 0 ] && sortie_contient "existe déjà"'

echo
echo "init et ou"
W=$T/travail/site; mkdir -p "$W/src/lib"
cd "$W"
joue_avec 'oui\npartagee\n' "$S" init clients/machin/site
verifie "crée le projet"                      '[ -f "$CAIRN/clients/machin/site/contexte.md" ]'
verifie "crée le groupe au passage"           '[ -f "$CAIRN/clients/machin/_commun/index.md" ]'
verifie "note le chemin de travail"           'fichier_contient "$CAIRN/clients/machin/site/contexte.md" "chemin: $W"'
verifie "applique les réponses du rituel"     'fichier_contient "$CAIRN/clients/machin/site/contexte.md" "diffusion: partagee"'
verifie "pose le marqueur"                    'fichier_contient "$W/.cairn" "projet: clients/machin/site"'
joue "$S" ou
verifie "ou retrouve le projet"               'sortie_contient "rattaché à : clients/machin/site"'
cd "$W/src/lib"
joue "$S" ou
verifie "ou remonte au marqueur d'un parent"  'sortie_contient "rattaché à : clients/machin/site"'
rm "$W/.cairn"
joue "$S" ou
verifie "ou résout par contexte.md depuis un sous-dossier" 'sortie_contient "rattaché à : clients/machin/site"'
cd "$W"
joue "$S" init
verifie "init sur un projet connu réécrit le marqueur" '[ "$CODE" = 0 ] && fichier_contient "$W/.cairn" "projet: clients/machin/site"'

echo
echo "le plus spécifique gagne"
LARGE=$T/travail; mkdir -p "$LARGE/autre"
cd "$LARGE"
joue_avec 'oui\n\n' "$S" init perso/tout
cd "$W/src"
joue "$S" ou
verifie "un projet large n'avale pas le projet précis" 'sortie_contient "rattaché à : clients/machin/site"'
cd "$LARGE/autre"
joue "$S" ou
verifie "le projet large couvre ce qui n'est pas rattaché ailleurs" 'sortie_contient "rattaché à : perso/tout"'

echo
echo "chemins difficiles"
E="$T/mon projet/avec espaces"; mkdir -p "$E"
cd "$E"
joue_avec '\n\n' "$S" init clients/espaces
verifie "un chemin avec espaces est noté tel quel" 'fichier_contient "$CAIRN/clients/espaces/contexte.md" "chemin: $E"'
rm "$E/.cairn"
joue "$S" ou
verifie "et se résout par contexte.md"         'sortie_contient "rattaché à : clients/espaces"'
X="$T/a&b|c"; mkdir -p "$X"
cd "$X"
joue_avec '\n\n' "$S" init clients/signes
verifie "un chemin avec & et | ne casse pas la substitution" 'fichier_contient "$CAIRN/clients/signes/contexte.md" "chemin: $X"'

echo
echo "sans mémoire"
N=$T/telechargements; mkdir -p "$N/sous"
cd "$N"
joue "$S" init --aucun
verifie "init --aucun pose un marqueur aucun"  'fichier_contient "$N/.cairn" "projet: aucun"'
cd "$N/sous"
joue "$S" ou
verifie "ou le dit, depuis un sous-dossier"    'sortie_contient "déclaré sans mémoire"'
joue "$S" init
verifie "init ne repose pas la question"       '[ "$CODE" = 0 ] && sortie_contient "déclaré sans mémoire"'
joue_avec 'aucun\n' "$S" init
cd "$T"; mkdir -p "$T/bureau"; cd "$T/bureau"
joue_avec 'aucun\n' "$S" init
verifie "répondre aucun au rituel pose le marqueur" 'fichier_contient "$T/bureau/.cairn" "projet: aucun"'

echo
echo "refus"
cd "$W"
mkdir -p "$W/module"; cd "$W/module"
joue_avec 'o\n\n\n' "$S" init clients/machin/site/module
verifie "refuse un projet dans un projet"      '[ "$CODE" != 0 ] && sortie_contient "un projet n'"'"'en contient pas d'"'"'autre"'
joue "$S" projet commun/x
verifie "refuse un emplacement réservé"        '[ "$CODE" != 0 ] && sortie_contient "réservé"'
joue "$S" projet sansdomaine
verifie "refuse un projet hors domaine"        '[ "$CODE" != 0 ]'
joue "$S" projet clients/machin/site
verifie "refuse un projet existant"            '[ "$CODE" != 0 ] && sortie_contient "existe déjà"'

echo
echo "index"
P=$CAIRN/clients/machin/site
cat > "$P/choix-du-cms.md" <<'EOF'
---
titre: Le CMS est WordPress
description: choisi pour la relève, pas pour la technique
nature: decision
cree: 06/09/2026
maj: 06/09/2026
statut: actif
---

WordPress.

**Pourquoi :** la personne qui reprendra le site le connaît déjà.
EOF
joue "$S" index
verifie "signale un souvenir absent de l'index" 'sortie_contient "manquant" && sortie_contient "choix-du-cms.md"'
joue "$S" index --appliquer
verifie "l'ajoute"                              'fichier_contient "$P/index.md" "- [Le CMS est WordPress](choix-du-cms.md) · choisi pour la relève, pas pour la technique"'
sed -i.bak 's/^description: .*/description: choisi pour la relève/' "$P/choix-du-cms.md"; rm -f "$P/choix-du-cms.md.bak"
printf '\n## Un intertitre\n\n- [Fantôme](disparu.md) · ce fichier n'"'"'existe pas\n' >> "$P/index.md"
joue "$S" index
verifie "signale une description qui a dérivé" 'sortie_contient "différent"'
verifie "signale une ligne orpheline"          'sortie_contient "en trop" && sortie_contient "disparu.md"'
joue "$S" index --appliquer
verifie "recalcule la ligne"                    'fichier_contient "$P/index.md" "· choisi pour la relève" && ! fichier_contient "$P/index.md" "pour la technique"'
verifie "retire l'orpheline, garde l'intertitre" '! fichier_contient "$P/index.md" "disparu.md" && fichier_contient "$P/index.md" "## Un intertitre"'
joue "$S" index
verifie "puis ne trouve plus rien"              'sortie_contient "correspondent"'

echo
echo "methode"
mkdir -p "$CAIRN_SKILLS"; cp -R "$DEPOT/skill/"* "$CAIRN_SKILLS/"
rm -f "$CAIRN_SKILLS/README.md"
joue "$S" methode
verifie "tout est à jour après l'installation, sauf le bloc absent" 'sortie_contient "absent               bloc Cairn" && sortie_contient "en retard 0"'
printf '# Mes instructions\n\nNe touche pas à ceci.\n' > "$CAIRN_INSTRUCTIONS"
joue "$S" methode --appliquer
verifie "pose le bloc à la fin des instructions existantes" 'fichier_contient "$CAIRN_INSTRUCTIONS" "Ne touche pas à ceci." && fichier_contient "$CAIRN_INSTRUCTIONS" "<!-- cairn:debut -->" && fichier_contient "$CAIRN_INSTRUCTIONS" "<!-- cairn:fin -->" && fichier_contient "$CAIRN_INSTRUCTIONS" "# Mémoire : méthode Cairn" && fichier_contient "$CAIRN_INSTRUCTIONS" "## Ce qu'"'"'il ne faut pas retenir"'
joue "$S" methode
verifie "puis tout est à jour"                  'sortie_contient "Tout est à jour"'

# Le dépôt avance : la copie est en retard.
printf '\nLigne ajoutée par le dépôt.\n' >> "$DEPOT/gabarits/journal.md"
commit_depot "Le dépôt avance"
joue "$S" methode
verifie "voit un retard"                        'sortie_contient "en retard            $CAIRN/gabarits/journal.md"'
joue "$S" methode --appliquer
verifie "l'aligne"                              'fichier_contient "$CAIRN/gabarits/journal.md" "Ligne ajoutée par le dépôt."'

# Adaptation locale, dépôt immobile : on ne touche à rien.
sed -i.bak '1s/^---$/---\ntitre: Mon titre à moi/' "$CAIRN/gabarits/memoire.md"; rm -f "$CAIRN/gabarits/memoire.md.bak"
joue "$S" methode
verifie "une adaptation locale est laissée tranquille" 'sortie_contient "adapté sur place     $CAIRN/gabarits/memoire.md" && sortie_contient "Tout est à jour"'

# Les deux bougent, à des endroits différents : fusion.
printf '\nAjout du dépôt en bas.\n' >> "$DEPOT/gabarits/memoire.md"
commit_depot "Le dépôt modifie le gabarit"
joue "$S" methode
verifie "voit qu'il faut fusionner"             'sortie_contient "à fusionner          $CAIRN/gabarits/memoire.md"'
joue "$S" methode --appliquer
verifie "fusionne à trois voies"                'sortie_contient "fusionné" && fichier_contient "$CAIRN/gabarits/memoire.md" "Mon titre à moi" && fichier_contient "$CAIRN/gabarits/memoire.md" "Ajout du dépôt en bas."'
verifie "garde l'ancienne version"              '[ -f "$CAIRN/gabarits/memoire.md.avant-maj" ]'
joue "$S" methode
verifie "et considère la fusion comme une adaptation" 'sortie_contient "Tout est à jour"'

# Les deux bougent au même endroit : conflit, puis --forcer.
printf 'Version locale de la première ligne\n' > "$CAIRN/gabarits/ecartes.md.new"
tail -n +2 "$CAIRN/gabarits/ecartes.md" >> "$CAIRN/gabarits/ecartes.md.new"; mv "$CAIRN/gabarits/ecartes.md.new" "$CAIRN/gabarits/ecartes.md"
printf 'Version du dépôt de la première ligne\n' > "$DEPOT/gabarits/ecartes.md.new"
tail -n +2 "$DEPOT/gabarits/ecartes.md" >> "$DEPOT/gabarits/ecartes.md.new"; mv "$DEPOT/gabarits/ecartes.md.new" "$DEPOT/gabarits/ecartes.md"
commit_depot "Conflit"
joue "$S" methode --appliquer
verifie "signale un conflit et ne touche pas au fichier" 'sortie_contient "conflit" && fichier_contient "$CAIRN/gabarits/ecartes.md" "Version locale"'
joue "$S" methode --forcer
verifie "--forcer écrase en gardant une copie"  'fichier_contient "$CAIRN/gabarits/ecartes.md" "Version du dépôt" && fichier_contient "$CAIRN/gabarits/ecartes.md.avant-maj" "Version locale"'

# Le bloc d'instructions évolue dans le dépôt : recalculé entre ses marqueurs.
sed -i.bak 's/^Ma mémoire suit la méthode Cairn/Ma mémoire suit la méthode Cairn, version test,/' "$DEPOT/adaptateurs/claude-code.md"; rm -f "$DEPOT/adaptateurs/claude-code.md.bak"
commit_depot "Le bloc change"
joue "$S" methode
verifie "voit le bloc en retard"                'sortie_contient "en retard            bloc Cairn"'
joue "$S" methode --appliquer
verifie "recalcule le bloc sans toucher au reste" 'fichier_contient "$CAIRN_INSTRUCTIONS" "version test," && fichier_contient "$CAIRN_INSTRUCTIONS" "Ne touche pas à ceci." && [ "$(grep -c "cairn:debut" "$CAIRN_INSTRUCTIONS")" = 1 ]'

# Un skill absent est posé, un skill supprimé du dépôt n'est pas touché.
rm -rf "$CAIRN_SKILLS/relire"
joue "$S" methode --appliquer
verifie "repose un skill absent"                '[ -f "$CAIRN_SKILLS/relire/SKILL.md" ]'
joue "$S" methode
verifie "le script lui-même est à jour"         'sortie_contient "Tout est à jour"'

echo
echo "verifier"
cd "$W"
joue "$S" verifier
verifie "dit que le profil est au gabarit"      'sortie_contient "profil        encore au gabarit"'
verifie "dit que la voix est au gabarit"        'sortie_contient "voix          encore au gabarit"'
verifie "compte les règles"                     'sortie_contient "règles        2 sur 12"'
verifie "voit le bloc d'instructions à jour"    'sortie_contient "bloc Cairn à jour"'
verifie "compte les skills"                     'sortie_contient "skills        12 sur 12"'
verifie "voit le dossier courant"               'sortie_contient "rattaché à : clients/machin/site"'
printf '# Moi\n\nDéveloppeuse.\n\n**Pourquoi :** parce que.\n' > "$CAIRN/commun/profil.md"
joue "$S" verifier
verifie "voit le profil rempli"                 'sortie_contient "profil        rempli"'

echo
echo "aide"
joue "$S" aide
verifie "affiche AIDE.md et l'état"             'sortie_contient "Cairn, en une page" && sortie_contient "projets    : "'

echo
echo "$reussis réussi(s), $rates raté(s)."
[ "$rates" = 0 ]
