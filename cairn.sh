#!/bin/sh
# Cairn, méthode de mémoire pour assistants IA
# https://github.com/Spreadtheflow/cairn
#
# Ce script est un raccourci, pas la méthode. Tout ce qu'il fait peut se faire
# à la main : copier un dossier, copier un gabarit, remplir quelques lignes.

set -eu

# Résout $0 à travers d'éventuels liens symboliques. Un poste peut très bien
# pointer son cairn vers un dépôt de travail : « installer » a besoin du dépôt,
# et « methode » doit écrire dans le vrai fichier plutôt que remplacer le lien.
BINAIRE=$0
tours=0
while [ -L "$BINAIRE" ] && [ "$tours" -lt 10 ]; do
    cible=$(readlink "$BINAIRE")
    case "$cible" in
        /*) BINAIRE=$cible ;;
        *)  BINAIRE=$(dirname "$BINAIRE")/$cible ;;
    esac
    tours=$((tours + 1))
done
SOURCE=$(CDPATH= cd -- "$(dirname -- "$BINAIRE")" && pwd)
SCRIPT=$SOURCE/$(basename -- "$BINAIRE")
AUJOURDHUI=$(date +%d/%m/%Y)

# Les dossiers réservés à la racine du cairn : tout autre dossier est un domaine.
RESERVES="commun archive gabarits a-trier"

usage() {
    cat <<'USAGE'
Usage :
  cairn.sh aide                    rappelle comment ça marche, et l'état du cairn
  cairn.sh verifier                diagnostic : profil, voix, socle, instructions, skills, index
  cairn.sh init [chemin|--aucun]   rattache le DOSSIER COURANT à un projet, ou le déclare sans mémoire
  cairn.sh ou                      dit à quel projet le dossier courant est rattaché
  cairn.sh installer [chemin]      crée le cairn lui-même (une fois, par défaut ~/cairn)
  cairn.sh groupe <chemin>         ajoute un dossier de rangement avec son _commun
  cairn.sh projet <chemin>         crée un projet sans se placer dans son dossier
  cairn.sh index [--appliquer]     compare les index aux en-têtes, et les recalcule
  cairn.sh methode [--appliquer]   dit si la méthode installée est en retard, et l'aligne

Les chemins de projet sont relatifs à la racine du cairn, aussi profonds que voulu :
  cd ~/travail/nouveau-site && cairn.sh init
  cairn.sh groupe clients/orsay-mutuelle
  cairn.sh projet clients/orsay-mutuelle/audit-conformite

Le cairn utilisé est $CAIRN s'il est défini, sinon ~/cairn.
USAGE
    exit 1
}

cairn_racine() {
    racine=${CAIRN:-$HOME/cairn}
    if [ ! -d "$racine" ]; then
        echo "Pas de cairn dans $racine. Créez-le d'abord : cairn.sh installer" >&2
        exit 1
    fi
    printf '%s' "$racine"
}

# Remplace un motif par une valeur dans un fichier, sans dépendre de GNU sed.
# La valeur est protégée : un chemin peut contenir |, & ou une barre oblique
# inverse sans casser l'expression.
remplacer() {
    motif=$1 fichier=$3
    valeur=$(printf '%s' "$2" | sed 's/[\\&|]/\\&/g')
    tmp=$(mktemp)
    sed "s|$motif|$valeur|" "$fichier" > "$tmp" && mv "$tmp" "$fichier"
}

# Refuse les emplacements réservés et les chemins qui sortent du cairn.
verifier_chemin() {
    case "$1" in
        commun|archive|gabarits|a-trier|commun/*|archive/*|gabarits/*|a-trier/*)
            echo "\"$1\" est un emplacement réservé." >&2; exit 1 ;;
        /*|*/../*|../*)
            echo "Donnez un chemin relatif à la racine du cairn." >&2; exit 1 ;;
    esac
}

# Les domaines : les dossiers à la racine, hors réservés.
domaines_de() {
    for d in "$1"/*/; do
        [ -d "$d" ] || continue
        n=$(basename "$d")
        case " $RESERVES " in *" $n "*) continue ;; esac
        printf '%s ' "$n"
    done
}

# Les contexte.md des projets, hors gabarits et archive, un par ligne.
contextes_de() {
    find "$1" -name contexte.md -not -path "*/gabarits/*" -not -path "*/archive/*" 2>/dev/null
}

cmd_installer() {
    racine=${1:-${CAIRN:-$HOME/cairn}}
    if [ -e "$racine" ]; then
        echo "$racine existe déjà. Rien n'a été touché." >&2
        exit 1
    fi
    mkdir -p "$racine"
    cp -R "$SOURCE/squelette/." "$racine/"
    cp -R "$SOURCE/gabarits" "$racine/gabarits"
    cp "$SOURCE/METHODE.md" "$SOURCE/DOCTRINE.md" "$SOURCE/AIDE.md" "$SOURCE/AIDE.en.md" "$racine/"
    if command -v git >/dev/null 2>&1 && [ -d "$SOURCE/.git" ]; then
        noter_source "$(git -C "$SOURCE" rev-parse HEAD)"
    fi

    for f in "$racine/commun/profil.md" "$racine/commun/regles.md" "$racine/commun/voix.md"; do
        [ -f "$f" ] && remplacer '05/09/2026' "$AUJOURDHUI" "$f"
    done

    cat <<TERMINE

Cairn créé dans $racine

Trois choses à faire, dans cet ordre :

  1. Remplissez $racine/commun/profil.md, puis $racine/commun/voix.md
     C'est ce qui sera lu au début de chaque session.

  2. Branchez votre assistant.
     Voir adaptateurs/ dans le dépôt de la méthode.

  3. Placez-vous dans un dossier de travail et lancez :
     cairn.sh init

Pour revoir comment ça marche à tout moment : cairn.sh aide
Pour savoir ce qui manque encore : cairn.sh verifier

Pour l'historique et la sauvegarde, un git init dans $racine est une bonne idée
dès maintenant : tout ce que vous ferez ensuite devient réversible.

TERMINE
}

cmd_groupe() {
    [ $# -eq 1 ] || usage
    chemin=$1
    verifier_chemin "$chemin"
    racine=$(cairn_racine)
    [ ! -d "$racine/$chemin" ] || { echo "$chemin existe déjà." >&2; exit 1; }

    mkdir -p "$racine/$chemin/_commun"
    printf '# Commun de %s\n\n<!-- Ce qui vaut pour tout ce qui se trouve en dessous, et pas au-delà.\n     Une ligne par fichier. -->\n' \
        "$chemin" > "$racine/$chemin/_commun/index.md"
    echo "Groupe créé : $racine/$chemin"
}

# Pose les quatre questions du rituel. Résultat dans $r_travail, $r_capture,
# $r_diffusion. Le chemin de travail peut être imposé par le premier argument.
rituel() {
    echo
    echo "Quatre questions, une seule fois. Entrée accepte la valeur par défaut."
    echo
    if [ $# -eq 1 ] && [ -n "$1" ]; then
        r_travail=$1
        echo "Dossier de travail : $r_travail"
    else
        printf 'Où se trouve le dossier de travail ? [aucun] : '
        read -r r_travail || r_travail=""
        [ -n "$r_travail" ] || r_travail="(aucun)"
    fi

    printf 'On capture de la mémoire ici ? (oui / non / a-la-demande) [oui] : '
    read -r r_capture || r_capture=""
    [ -n "$r_capture" ] || r_capture="oui"

    echo
    echo "Où pourra finir ce qui sera écrit ici ?"
    echo "  privee    ça reste chez moi. On écrit en clair, noms compris."
    echo "  partagee  ce sera remis à un client ou un collègue."
    echo "  publique  ça peut finir publié. On anonymise en écrivant."
    printf 'Diffusion ? [privee] : '
    read -r r_diffusion || r_diffusion=""
    [ -n "$r_diffusion" ] || r_diffusion="privee"
}

# Crée l'arborescence d'un projet. $1 chemin dans le cairn, $2 dossier de travail.
creer_projet() {
    chemin=$1 travail=$2
    racine=$(cairn_racine)
    projet="$racine/$chemin"
    nom=$(basename "$chemin")
    domaine=$(printf '%s' "$chemin" | cut -d/ -f1)

    mkdir -p "$projet"
    cp "$racine/gabarits/contexte.md" "$projet/contexte.md"
    cp "$racine/gabarits/journal.md"  "$projet/journal.md"
    cp "$racine/gabarits/index.md"    "$projet/index.md"

    remplacer 'nom-stable-du-projet' "$nom"                    "$projet/contexte.md"
    remplacer '^domaine: .*$'        "domaine: $domaine"       "$projet/contexte.md"
    remplacer '^chemin: .*$'         "chemin: $travail"        "$projet/contexte.md"
    remplacer '^capture: .*$'        "capture: $r_capture"     "$projet/contexte.md"
    remplacer '^diffusion: .*$'      "diffusion: $r_diffusion" "$projet/contexte.md"
    remplacer '05/09/2026'           "$AUJOURDHUI"             "$projet/contexte.md"
    remplacer '05/09/2026'           "$AUJOURDHUI"             "$projet/journal.md"
    remplacer '# Nom du projet'      "# $nom"                  "$projet/index.md"
}

# Refuse un projet à l'intérieur d'un autre projet.
verifier_pas_imbrique() {
    racine=$(cairn_racine)
    parent=$(dirname "$1")
    while [ "$parent" != "." ] && [ "$parent" != "/" ]; do
        if [ -f "$racine/$parent/contexte.md" ]; then
            echo "$parent est déjà un projet ; un projet n'en contient pas d'autre." >&2
            echo "Transformez-le en groupe : déplacez son contexte.md dans un sous-dossier." >&2
            exit 1
        fi
        parent=$(dirname "$parent")
    done
}

cmd_projet() {
    [ $# -eq 1 ] || usage
    chemin=$1
    verifier_chemin "$chemin"
    case "$chemin" in
        */*) : ;;
        *)   echo "Un projet vit dans un domaine. Essayez : $chemin/quelque-chose" >&2
             exit 1 ;;
    esac
    racine=$(cairn_racine)
    [ ! -d "$racine/$chemin" ] || { echo "$chemin existe déjà." >&2; exit 1; }
    verifier_pas_imbrique "$chemin"

    rituel
    creer_projet "$chemin" "$r_travail"

    echo
    echo "Projet créé : $racine/$chemin"
    if [ "$r_capture" = "non" ]; then
        echo "Capture désactivée : rien ne sera retenu ici tant que vous ne changez"
        echo "pas cette ligne dans contexte.md."
    else
        echo "Complétez contexte.md, c'est ce qui sera lu en premier."
    fi
    echo
}

# Le marqueur .cairn, dans le dossier donné ou dans un de ses parents. Affiche
# la valeur de « projet: », qui peut être « aucun » : ce dossier a été déclaré
# sans mémoire, et on ne redemande pas.
marqueur() {
    d=$1
    while [ -n "$d" ]; do
        if [ -f "$d/.cairn" ]; then
            sed -n 's/^projet: *//p' "$d/.cairn" | head -1
            return 0
        fi
        [ "$d" != "/" ] || break
        d=$(dirname "$d")
    done
    return 0
}

# Cherche le projet dont le chemin de travail contient le dossier donné.
resoudre() {
    racine=$(cairn_racine)
    cible=$1
    m=$(marqueur "$cible")
    if [ -n "$m" ]; then
        printf '%s' "$m"
        return 0
    fi
    # Le chemin le PLUS SPÉCIFIQUE gagne : un projet déclaré sur un dossier large
    # (une racine, un home) ne doit pas avaler les projets rangés en dessous.
    meilleur=""; longueur=0
    liste=$(mktemp); contextes_de "$racine" > "$liste"
    while IFS= read -r c; do
        [ -n "$c" ] || continue
        t=$(sed -n 's/^chemin: *//p' "$c" | head -1)
        [ -n "$t" ] || continue
        [ "$t" = "(aucun)" ] && continue
        case "$cible" in
            "$t"|"$t"/*)
                n=${#t}
                if [ "$n" -gt "$longueur" ]; then
                    longueur=$n
                    d=$(dirname "$c")
                    meilleur="${d#$racine/}"
                fi ;;
        esac
    done < "$liste"
    rm -f "$liste"
    [ -n "$meilleur" ] && printf '%s' "$meilleur"
    return 0
}

# Chemin de travail declare par un projet du cairn.
chemin_de() {
    racine=$(cairn_racine)
    sed -n 's/^chemin: *//p' "$racine/$1/contexte.md" 2>/dev/null | head -1
}

# Une ligne sur le dossier courant, pour aide et verifier.
ligne_courant() {
    trouve=$(resoudre "$(pwd)")
    if [ "$trouve" = "aucun" ]; then
        echo "- dossier courant : déclaré sans mémoire (marqueur .cairn)"
    elif [ -n "$trouve" ]; then
        echo "- dossier courant rattaché à : $trouve"
    else
        echo "- dossier courant : non rattaché (cairn.sh init pour le rattacher)"
    fi
}

cmd_aide() {
    racine=$(cairn_racine)
    if [ -f "$racine/AIDE.md" ]; then
        cat "$racine/AIDE.md"
    else
        echo "AIDE.md est absent du cairn." >&2
        echo "Récupérez-le sur https://github.com/Spreadtheflow/cairn" >&2
    fi
    domaines=$(domaines_de "$racine")
    projets=$(contextes_de "$racine" | wc -l | tr -d ' ')
    echo
    echo "---"
    echo
    echo "## Votre cairn"
    echo
    echo "- ici        : $racine"
    echo "- domaines   : ${domaines:-aucun}"
    echo "- projets    : $projets"
    if [ -f "$ETAT_METHODE" ]; then
        echo "- méthode    : alignée sur le dépôt le $(cut -d' ' -f2 < "$ETAT_METHODE")"
    else
        echo "- méthode    : jamais vérifiée (cairn.sh methode)"
    fi
    ligne_courant
    echo
    echo "Pour un diagnostic complet : cairn.sh verifier"
    echo
}

cmd_ou() {
    ici=$(pwd)
    trouve=$(resoudre "$ici")
    if [ "$trouve" = "aucun" ]; then
        echo "$ici a été déclaré sans mémoire, par un marqueur .cairn ici ou dans un parent."
        echo "Pour changer d'avis, supprimez ce marqueur, puis : cairn.sh init"
    elif [ -n "$trouve" ]; then
        racine=$(cairn_racine)
        echo "$ici"
        echo "  rattaché à : $trouve"
        echo "  mémoire    : $racine/$trouve"
    else
        echo "$ici n'est rattaché à aucun projet du cairn."
        echo "Pour le rattacher : cairn.sh init"
        echo "Pour ne plus jamais poser la question ici : cairn.sh init --aucun"
    fi
}

cmd_init() {
    ici=$(pwd)
    racine=$(cairn_racine)

    if [ $# -eq 1 ] && [ "$1" = "--aucun" ]; then
        printf 'cairn: %s\nprojet: aucun\n' "$racine" > "$ici/.cairn"
        echo "Déclaré sans mémoire : $ici"
        echo "Aucun assistant ne proposera plus de rattacher ce dossier ni ses sous-dossiers."
        echo "Pour changer d'avis, supprimez $ici/.cairn"
        exit 0
    fi

    deja=$(resoudre "$ici")
    if [ "$deja" = "aucun" ] && [ $# -eq 0 ]; then
        echo "Ce dossier a été déclaré sans mémoire, par un marqueur .cairn ici ou dans un parent."
        echo "Pour le rattacher quand même, donnez le chemin du projet : cairn.sh init domaine/projet"
        exit 0
    fi
    if [ -n "$deja" ] && [ "$deja" != "aucun" ]; then
        # Rattaché exactement ici : rien à faire.
        # Couvert par un projet plus large : on peut vouloir un projet propre.
        if [ "$(chemin_de "$deja")" = "$ici" ]; then
            echo "Ce dossier est déjà rattaché à : $deja"
            if [ ! -f "$ici/.cairn" ]; then
                printf 'cairn: %s\nprojet: %s\n' "$racine" "$deja" > "$ici/.cairn"
                echo "Marqueur .cairn écrit."
            fi
            exit 0
        fi
        echo "Ce dossier est couvert par un projet plus large : $deja"
        if [ $# -eq 0 ]; then
            printf 'Créer un projet propre à ce dossier ? [o/N] : '
            read -r rep || rep=""
            case "$rep" in
                o|O|oui|OUI) : ;;
                *) echo "On garde $deja."
                   printf 'cairn: %s\nprojet: %s\n' "$racine" "$deja" > "$ici/.cairn"
                   echo "Marqueur .cairn écrit vers $deja."
                   exit 0 ;;
            esac
        fi
        echo "Le nouveau projet primera, son chemin étant plus précis."
    fi

    if [ $# -eq 1 ]; then
        chemin=$1
    else
        echo
        echo "Ce dossier n'est rattaché à aucun projet."
        echo "Domaines existants : $(domaines_de "$racine")"
        printf 'Chemin du projet dans le cairn (ex. clients/machin/site), ou « aucun » : '
        read -r chemin || chemin=""
        [ -n "$chemin" ] || { echo "Annulé." >&2; exit 1; }
    fi

    if [ "$chemin" = "aucun" ]; then
        printf 'cairn: %s\nprojet: aucun\n' "$racine" > "$ici/.cairn"
        echo "Déclaré sans mémoire : $ici. Pour changer d'avis, supprimez $ici/.cairn"
        exit 0
    fi

    verifier_chemin "$chemin"
    case "$chemin" in */*) : ;; *) echo "Un projet vit dans un domaine." >&2; exit 1 ;; esac
    [ ! -d "$racine/$chemin" ] || { echo "$chemin existe déjà dans le cairn." >&2; exit 1; }
    verifier_pas_imbrique "$chemin"

    parent=$(dirname "$chemin")
    [ -d "$racine/$parent" ] || { mkdir -p "$racine/$parent/_commun"
        printf '# Commun de %s\n\n' "$parent" > "$racine/$parent/_commun/index.md"
        echo "Groupe créé au passage : $parent"; }

    rituel "$ici"
    creer_projet "$chemin" "$ici"
    printf 'cairn: %s\nprojet: %s\n' "$racine" "$chemin" > "$ici/.cairn"

    echo
    echo "Rattaché."
    echo "  dossier de travail : $ici"
    echo "  mémoire            : $racine/$chemin"
    echo "  marqueur           : $ici/.cairn"
    if [ "$r_capture" = "non" ]; then
        echo
        echo "Capture désactivée : rien ne sera retenu ici."
    fi
    echo
}

# ---------------------------------------------------------------------------
# L'index se recalcule.
#
# Une ligne d'index est la copie du titre et de la description d'un souvenir.
# Une copie dérive ; celle-ci se recalcule depuis les en-têtes. Les intertitres
# et les commentaires d'un index sont conservés : seules les lignes de souvenir
# sont recalculées, ajoutées ou retirées.
# ---------------------------------------------------------------------------

# L'en-tête YAML d'un fichier, ou rien s'il n'en a pas.
entete_de() {
    awk 'NR==1 { if ($0 != "---") exit; next } $0 == "---" { exit } { print }' "$1"
}

champ_de() {
    printf '%s\n' "$1" | sed -n "s/^$2: *//p" | head -1
}

# Les souvenirs d'un dossier : les .md porteurs d'un en-tête avec un titre,
# hors fichiers de structure.
souvenirs_de() {
    for f in "$1"/*.md; do
        [ -f "$f" ] || continue
        case $(basename "$f") in
            contexte.md|index.md|journal.md|journal-*.md|retours.md|ecartes.md|propositions-*.md) continue ;;
        esac
        e=$(entete_de "$f")
        [ -n "$(champ_de "$e" titre)" ] || continue
        printf '%s\n' "$f"
    done
}

ligne_index() {
    e=$(entete_de "$1")
    printf '%s [%s](%s) · %s\n' '-' "$(champ_de "$e" titre)" "$(basename "$1")" "$(champ_de "$e" description)"
}

# Compare un index à son dossier. Affiche les écarts, retourne leur nombre
# dans $ecarts. Avec « appliquer », réécrit l'index.
index_dossier() {
    dossier=$1 appliquer=$2
    index="$dossier/index.md"
    attendu=$(mktemp)
    souvenirs_de "$dossier" | while IFS= read -r f; do ligne_index "$f"; done > "$attendu"
    ecarts=0
    while IFS= read -r ligne; do
        [ -n "$ligne" ] || continue
        fichier=$(printf '%s' "$ligne" | sed 's/.*](\([^)]*\)).*/\1/')
        if grep -qxF -- "$ligne" "$index"; then continue; fi
        ecarts=$((ecarts+1))
        if grep -qF -- "]($fichier)" "$index"; then
            echo "  différent   $dossier/$fichier"
        else
            echo "  manquant    $dossier/$fichier"
        fi
    done < "$attendu"
    # Les lignes de l'index qui pointent vers un fichier disparu.
    orphelins=$(mktemp)
    sed -n 's/^- \[.*\](\([^)]*\.md\)).*/\1/p' "$index" | while IFS= read -r f; do
        [ -f "$dossier/$f" ] || printf '%s\n' "$f"
    done > "$orphelins"
    while IFS= read -r f; do
        [ -n "$f" ] || continue
        echo "  en trop     $dossier/$f"
        ecarts=$((ecarts+1))
    done < "$orphelins"
    rm -f "$orphelins"
    if [ "$ecarts" -gt 0 ] && [ "$appliquer" = 1 ]; then
        tmp=$(mktemp)
        awk -v attendu="$attendu" '
            BEGIN { while ((getline l < attendu) > 0) { f = l; sub(/.*\]\(/, "", f); sub(/\).*/, "", f); ligne[f] = l; ordre[++n] = f } }
            /^- \[.*\]\([^)]*\.md\)/ { f = $0; sub(/.*\]\(/, "", f); sub(/\).*/, "", f)
                if (f in ligne) { print ligne[f]; vu[f] = 1 } ; next }
            { print }
            END { for (i = 1; i <= n; i++) if (!(ordre[i] in vu)) print ligne[ordre[i]] }
        ' "$index" > "$tmp" && mv "$tmp" "$index"
        echo "  recalculé   $index"
    fi
    rm -f "$attendu"
}

cmd_index() {
    appliquer=0
    for a in "$@"; do
        case "$a" in
            --appliquer) appliquer=1 ;;
            *) echo "Usage : cairn.sh index [--appliquer]" >&2; exit 1 ;;
        esac
    done
    racine=$(cairn_racine)
    total=0
    liste=$(mktemp)
    find "$racine" -name index.md -not -path "*/gabarits/*" -not -path "*/archive/*" 2>/dev/null | sort > "$liste"
    echo
    while IFS= read -r i; do
        [ -n "$i" ] || continue
        index_dossier "$(dirname "$i")" "$appliquer"
        total=$((total + ecarts))
    done < "$liste"
    rm -f "$liste"
    if [ "$total" = 0 ]; then
        echo "Les index correspondent aux en-têtes."
    elif [ "$appliquer" = 1 ]; then
        echo "$total écart(s) recalculé(s)."
    else
        echo "$total écart(s). cairn.sh index --appliquer pour recalculer."
    fi
    echo
}

# ---------------------------------------------------------------------------
# La méthode se recalcule, la mémoire jamais.
#
# Un cairn installé contient des copies du dépôt : METHODE.md, DOCTRINE.md,
# AIDE.md, les gabarits, les skills, le bloc d'instructions de l'assistant et
# ce script. Ce sont des dérivés, et un dérivé ne se maintient pas, il se
# recalcule. Cette commande est le recalcul.
#
# Elle ne touche jamais commun/, ni un projet, ni un journal, ni un contexte.md.
# Ces fichiers-là n'ont pas de source ailleurs : ils sont la mémoire.
#
# Une copie adaptée sur place n'est pas écrasée : si le dépôt a bougé aussi, on
# tente une fusion à trois voies depuis la version d'origine notée. Ce qui ne
# fusionne pas proprement est laissé tel quel et signalé.
# ---------------------------------------------------------------------------

DEPOT_METHODE=${CAIRN_DEPOT:-https://github.com/Spreadtheflow/cairn.git}
CACHE_METHODE="${XDG_CACHE_HOME:-$HOME/.cache}/cairn-methode"
ETAT_METHODE="${XDG_STATE_HOME:-$HOME/.local/state}/cairn/methode-source"
SKILLS_METHODE=${CAIRN_SKILLS:-$HOME/.claude/skills}
INSTRUCTIONS=${CAIRN_INSTRUCTIONS:-$HOME/.claude/CLAUDE.md}
ADAPTATEUR=adaptateurs/claude-code.md
MARQUE_DEBUT='<!-- cairn:debut -->'
MARQUE_FIN='<!-- cairn:fin -->'

# Note la version du dépôt d'où viennent les copies actuelles.
noter_source() {
    mkdir -p "$(dirname "$ETAT_METHODE")"
    printf '%s %s\n' "$1" "$AUJOURDHUI" > "$ETAT_METHODE"
}

source_notee() { [ -f "$ETAT_METHODE" ] && cut -d' ' -f1 < "$ETAT_METHODE" || true; }

# Récupère ou rafraîchit la copie de référence, dans le cache.
cache_methode() {
    if ! command -v git >/dev/null 2>&1; then
        echo "git est nécessaire pour vérifier la méthode." >&2
        echo "Sans lui, récupérez les fichiers à la main sur $DEPOT_METHODE" >&2
        exit 1
    fi
    if [ -d "$CACHE_METHODE/.git" ]; then
        git -C "$CACHE_METHODE" remote set-url origin "$DEPOT_METHODE"
        if git -C "$CACHE_METHODE" fetch -q origin 2>/dev/null; then
            git -C "$CACHE_METHODE" reset -q --hard FETCH_HEAD
        else
            echo "Dépôt injoignable, on compare avec la copie en cache." >&2
        fi
    else
        mkdir -p "$(dirname "$CACHE_METHODE")"
        git clone -q "$DEPOT_METHODE" "$CACHE_METHODE" || {
            echo "Impossible de récupérer $DEPOT_METHODE" >&2; exit 1; }
    fi
}

# Les couples "chemin dans le dépôt|chemin sur le disque".
couples_methode() {
    racine=$1
    for f in METHODE.md DOCTRINE.md AIDE.md AIDE.en.md; do
        printf '%s|%s\n' "$f" "$racine/$f"
    done
    for f in "$CACHE_METHODE"/gabarits/*.md; do
        [ -e "$f" ] || continue
        n=$(basename "$f"); printf 'gabarits/%s|%s\n' "$n" "$racine/gabarits/$n"
    done
    if [ -d "$SKILLS_METHODE" ]; then
        for d in "$CACHE_METHODE"/skill/*/; do
            [ -d "$d" ] || continue
            n=$(basename "$d")
            printf 'skill/%s/SKILL.md|%s\n' "$n" "$SKILLS_METHODE/$n/SKILL.md"
        done
    fi
    [ -f "$SCRIPT" ] && printf 'cairn.sh|%s\n' "$SCRIPT"
}

# La version d'un fichier du dépôt à la révision notée, dans un temporaire.
# Affiche le chemin du temporaire, ou rien si la base est inconnue.
version_base() {
    base=$(source_notee)
    [ -n "$base" ] || return 0
    git -C "$CACHE_METHODE" cat-file -e "$base:$1" 2>/dev/null || return 0
    tmp=$(mktemp)
    git -C "$CACHE_METHODE" show "$base:$1" > "$tmp" 2>/dev/null
    printf '%s' "$tmp"
}

# Le bloc d'instructions, entre ses deux marqueurs, marqueurs compris.
bloc_de() {
    awk -v d="$MARQUE_DEBUT" -v f="$MARQUE_FIN" '
        $0 == d { en = 1 } en { print } $0 == f { if (en) exit }' "$1"
}

# État d'une copie par rapport au dépôt et à la version notée :
#   ajour    identique au dépôt
#   absent   pas de copie
#   retard   la copie est restée à la version notée, le dépôt a bougé
#   adapte   la copie a été modifiée sur place, le dépôt n'a pas bougé
#   modifie  les deux ont bougé : fusion à trois voies possible
#   inconnu  la copie diffère et aucune version n'est notée
# Les trois fichiers sont donnés : référence, copie, base (vide si inconnue).
etat_de() {
    ref=$1 dst=$2 base=$3
    [ -f "$ref" ] || { echo inconnu; return; }
    [ -f "$dst" ] || { echo absent; return; }
    cmp -s "$ref" "$dst" && { echo ajour; return; }
    [ -n "$base" ] && [ -f "$base" ] || { echo inconnu; return; }
    cmp -s "$base" "$dst" && { echo retard; return; }
    cmp -s "$base" "$ref" && { echo adapte; return; }
    echo modifie
}

# Fusion à trois voies : copie locale, base notée, dépôt. Résultat dans $4.
# Réussit si aucun conflit.
fusionner() {
    git merge-file -p -L "copie locale" -L "version d'origine" -L "dépôt" "$2" "$3" "$1" > "$4" 2>/dev/null
}

# Copie en passant par un temporaire : ce script peut être sa propre cible.
poser() {
    # Écrire à travers un lien, jamais le remplacer.
    p_dst=$2; tours=0
    while [ -L "$p_dst" ] && [ "$tours" -lt 10 ]; do
        cible=$(readlink "$p_dst")
        case "$cible" in
            /*) p_dst=$cible ;;
            *)  p_dst=$(dirname "$p_dst")/$cible ;;
        esac
        tours=$((tours + 1))
    done
    set -- "$1" "$p_dst"
    mkdir -p "$(dirname "$2")"
    tmp="$2.cairn-tmp.$$"
    cp "$1" "$tmp"
    [ -x "$2" ] && chmod +x "$tmp"
    mv "$tmp" "$2"
}

# Pose le bloc d'instructions dans le fichier de l'assistant : entre les
# marqueurs s'ils existent, à la fin sinon, dans un fichier neuf s'il n'y en a pas.
poser_bloc() {
    pb_bloc=$1 pb_dst=$2
    mkdir -p "$(dirname "$pb_dst")"
    if [ ! -f "$pb_dst" ]; then
        cp "$pb_bloc" "$pb_dst"
    elif grep -qxF -- "$MARQUE_DEBUT" "$pb_dst"; then
        tmp=$(mktemp)
        awk -v bloc="$pb_bloc" -v d="$MARQUE_DEBUT" -v f="$MARQUE_FIN" '
            $0 == d && !fait { while ((getline l < bloc) > 0) print l; saute = 1; fait = 1; next }
            $0 == f && saute { saute = 0; next }
            !saute { print }' "$pb_dst" > "$tmp" && mv "$tmp" "$pb_dst"
    else
        { printf '\n'; cat "$pb_bloc"; } >> "$pb_dst"
    fi
}

# Traite un couple : affiche son état, l'aligne si demandé, et incrémente les
# compteurs. $1 état, $2 référence, $3 copie, $4 base, $5 nom lisible.
# $poser_fn est la fonction qui pose (poser ou poser_bloc).
traiter() {
    etat=$1 ref=$2 dst=$3 base=$4 nom=$5
    case "$etat" in
        ajour)  ajour=$((ajour+1)) ;;
        absent) absent=$((absent+1))
                echo "  absent               $nom"
                [ "$appliquer" = 1 ] && { $poser_fn "$ref" "$dst"; pose=$((pose+1)); } ;;
        retard) retard=$((retard+1))
                echo "  en retard            $nom"
                [ "$appliquer" = 1 ] && { $poser_fn "$ref" "$dst"; pose=$((pose+1)); } ;;
        adapte) adapte=$((adapte+1))
                echo "  adapté sur place     $nom   (le dépôt n'a pas bougé, rien à faire)"
                if [ "$forcer" = 1 ]; then
                    cp "$dst" "$dst.avant-maj"
                    $poser_fn "$ref" "$dst"; pose=$((pose+1))
                    echo "                       écrasé, ancienne version en $nom.avant-maj"
                fi ;;
        modifie) modifie=$((modifie+1))
                if [ "$appliquer" = 1 ]; then
                    fusion=$(mktemp)
                    if [ "$forcer" = 0 ] && fusionner "$ref" "$dst" "$base" "$fusion"; then
                        cp "$dst" "$dst.avant-maj"
                        $poser_fn "$fusion" "$dst"; pose=$((pose+1)); fusionne=$((fusionne+1))
                        echo "  fusionné             $nom   (ancienne version en $nom.avant-maj)"
                    elif [ "$forcer" = 1 ]; then
                        cp "$dst" "$dst.avant-maj"
                        $poser_fn "$ref" "$dst"; pose=$((pose+1))
                        echo "  écrasé               $nom   (ancienne version en $nom.avant-maj)"
                    else
                        conflit=$((conflit+1))
                        echo "  conflit              $nom   (adapté sur place ET dépôt modifié, fusion impossible)"
                    fi
                    rm -f "$fusion"
                else
                    echo "  à fusionner          $nom   (adapté sur place ET dépôt modifié)"
                fi ;;
        inconnu) inconnu=$((inconnu+1))
                echo "  différent            $nom   (aucune version d'origine notée)"
                if [ "$forcer" = 1 ]; then
                    cp "$dst" "$dst.avant-maj"
                    $poser_fn "$ref" "$dst"; pose=$((pose+1))
                    echo "                       écrasé, ancienne version en $nom.avant-maj"
                fi ;;
    esac
}

cmd_methode() {
    appliquer=0 forcer=0
    for a in "$@"; do
        case "$a" in
            --appliquer) appliquer=1 ;;
            --forcer)    appliquer=1; forcer=1 ;;
            *) echo "Option inconnue : $a" >&2
               echo "Usage : cairn.sh methode [--appliquer] [--forcer]" >&2; exit 1 ;;
        esac
    done
    racine=$(cairn_racine)
    cache_methode
    tete=$(git -C "$CACHE_METHODE" rev-parse HEAD)
    liste=$(mktemp); couples_methode "$racine" > "$liste"

    ajour=0 retard=0 adapte=0 modifie=0 inconnu=0 absent=0 pose=0 fusionne=0 conflit=0
    echo
    echo "Méthode : dépôt à $(git -C "$CACHE_METHODE" rev-parse --short HEAD), $DEPOT_METHODE"
    [ -n "$(source_notee)" ] || echo "Aucune version notée : ce qui diffère est signalé, jamais supposé en retard."
    echo
    poser_fn=poser
    while IFS='|' read -r src dst; do
        [ -n "$src" ] || continue
        base=$(version_base "$src")
        traiter "$(etat_de "$CACHE_METHODE/$src" "$dst" "$base")" "$CACHE_METHODE/$src" "$dst" "$base" "$dst"
        [ -n "$base" ] && rm -f "$base"
    done < "$liste"
    rm -f "$liste"

    # Le bloc d'instructions de l'assistant, entre ses marqueurs.
    if [ -f "$CACHE_METHODE/$ADAPTATEUR" ]; then
        ref=$(mktemp); bloc_de "$CACHE_METHODE/$ADAPTATEUR" > "$ref"
        extrait=$(mktemp); [ -f "$INSTRUCTIONS" ] && bloc_de "$INSTRUCTIONS" > "$extrait"
        [ -s "$extrait" ] || rm -f "$extrait"
        base=""
        b=$(version_base "$ADAPTATEUR")
        if [ -n "$b" ]; then base=$(mktemp); bloc_de "$b" > "$base"; rm -f "$b"; fi
        # L'état se calcule sur l'extrait ; l'écriture vise le fichier lui-même.
        etat=$(etat_de "$ref" "$extrait" "$base")
        if [ "$etat" = absent ]; then
            absent=$((absent+1))
            echo "  absent               bloc Cairn de $INSTRUCTIONS"
            [ "$appliquer" = 1 ] && { poser_bloc "$ref" "$INSTRUCTIONS"; pose=$((pose+1)); }
        elif [ "$etat" = retard ]; then
            retard=$((retard+1))
            echo "  en retard            bloc Cairn de $INSTRUCTIONS"
            [ "$appliquer" = 1 ] && { poser_bloc "$ref" "$INSTRUCTIONS"; pose=$((pose+1)); }
        elif [ "$etat" = ajour ]; then
            ajour=$((ajour+1))
        elif [ "$etat" = adapte ]; then
            adapte=$((adapte+1))
            echo "  adapté sur place     bloc Cairn de $INSTRUCTIONS   (le dépôt n'a pas bougé)"
            [ "$forcer" = 1 ] && { cp "$INSTRUCTIONS" "$INSTRUCTIONS.avant-maj"; poser_bloc "$ref" "$INSTRUCTIONS"; pose=$((pose+1)); }
        else
            fusion=$(mktemp)
            if [ "$appliquer" = 1 ] && [ "$forcer" = 0 ] && [ -n "$base" ] && fusionner "$ref" "$extrait" "$base" "$fusion"; then
                modifie=$((modifie+1)); fusionne=$((fusionne+1))
                cp "$INSTRUCTIONS" "$INSTRUCTIONS.avant-maj"
                poser_bloc "$fusion" "$INSTRUCTIONS"; pose=$((pose+1))
                echo "  fusionné             bloc Cairn de $INSTRUCTIONS"
            elif [ "$forcer" = 1 ]; then
                modifie=$((modifie+1))
                cp "$INSTRUCTIONS" "$INSTRUCTIONS.avant-maj"
                poser_bloc "$ref" "$INSTRUCTIONS"; pose=$((pose+1))
                echo "  écrasé               bloc Cairn de $INSTRUCTIONS   (ancienne version en $INSTRUCTIONS.avant-maj)"
            elif [ "$appliquer" = 1 ]; then
                modifie=$((modifie+1)); conflit=$((conflit+1))
                echo "  conflit              bloc Cairn de $INSTRUCTIONS   (adapté sur place ET dépôt modifié)"
            else
                if [ -n "$base" ]; then modifie=$((modifie+1)); echo "  à fusionner          bloc Cairn de $INSTRUCTIONS"
                else inconnu=$((inconnu+1)); echo "  différent            bloc Cairn de $INSTRUCTIONS   (aucune version d'origine notée)"; fi
            fi
            rm -f "$fusion"
        fi
        rm -f "$ref" "$base" "$extrait"
    fi

    echo
    echo "  à jour $ajour, en retard $retard, absent $absent, adapté $adapte, à fusionner $modifie, sans origine $inconnu"
    echo
    if [ "$appliquer" = 1 ]; then
        echo "$pose fichier(s) posé(s), dont $fusionne fusionné(s)."
        [ "$conflit" = 0 ] || echo "$conflit conflit(s) laissé(s) tel(s) quel(s). --forcer écrase, en gardant une copie .avant-maj."
        [ "$inconnu" = 0 ] || echo "$inconnu sans version d'origine, laissé(s). --forcer écrase, en gardant une copie .avant-maj."
    elif [ $((retard + absent + modifie)) -gt 0 ]; then
        echo "cairn.sh methode --appliquer pour aligner : les retards et absents sont posés, les adaptations fusionnées."
    elif [ "$inconnu" -gt 0 ]; then
        echo "Rien en retard. Ce qui diffère n'a pas de version d'origine notée : à reporter dans le dépôt, ou à écraser avec --forcer."
    else
        echo "Tout est à jour."
    fi
    # On ne note la version que si le disque lui correspond vraiment : sinon la
    # passe suivante prendrait un retard pour une modification locale.
    if [ "$appliquer" = 1 ]; then
        [ $((conflit + inconnu)) -eq 0 ] && noter_source "$tete"
    else
        [ $((retard + absent + modifie + inconnu)) -eq 0 ] && noter_source "$tete"
    fi
    echo
}

# ---------------------------------------------------------------------------
# Le diagnostic : ce qui manque pour que la mémoire serve.
# ---------------------------------------------------------------------------

# Le fichier est-il encore au gabarit ? On cherche la phrase que le gabarit
# demande de remplacer.
au_gabarit() {
    [ -f "$1" ] && grep -q 'Remplacez tout ce qui suit' "$1"
}

cmd_verifier() {
    racine=$(cairn_racine)
    afaire=0
    echo
    echo "Cairn : $racine"
    echo

    # Le socle.
    if [ ! -f "$racine/commun/profil.md" ]; then
        echo "  profil        absent : $racine/commun/profil.md"; afaire=$((afaire+1))
    elif au_gabarit "$racine/commun/profil.md"; then
        echo "  profil        encore au gabarit : c'est la première chose à remplir"; afaire=$((afaire+1))
    else
        echo "  profil        rempli"
    fi
    if [ ! -f "$racine/commun/voix.md" ]; then
        echo "  voix          absente : $racine/commun/voix.md (gabarits/voix.md pour commencer)"; afaire=$((afaire+1))
    elif au_gabarit "$racine/commun/voix.md"; then
        echo "  voix          encore au gabarit : à établir depuis quelques textes de la personne"; afaire=$((afaire+1))
    else
        echo "  voix          établie"
    fi
    if [ -f "$racine/commun/regles.md" ]; then
        n=$(grep -c '^[0-9][0-9]*\. ' "$racine/commun/regles.md" || true)
        if [ "$n" -gt 12 ]; then echo "  règles        $n sur 12 : le plafond est dépassé, fusionner ou retirer"; afaire=$((afaire+1))
        else echo "  règles        $n sur 12"; fi
    else
        echo "  règles        absentes : $racine/commun/regles.md"; afaire=$((afaire+1))
    fi
    n=0
    for f in "$racine"/commun/*.md; do
        [ -f "$f" ] || continue
        case $(basename "$f") in profil.md|regles.md|voix.md|retours.md|ecartes.md|index.md|propositions-*.md) continue ;; esac
        [ -n "$(champ_de "$(entete_de "$f")" nature)" ] && n=$((n+1))
    done
    if [ "$n" -gt 20 ]; then echo "  socle         $n souvenirs sur 20 : le plafond est dépassé"; afaire=$((afaire+1))
    elif [ "$n" -ge 15 ]; then echo "  socle         $n souvenirs sur 20 : on approche du plafond"
    else echo "  socle         $n souvenirs sur 20"; fi

    # Le raccordement de l'assistant.
    if [ ! -f "$INSTRUCTIONS" ]; then
        echo "  instructions  absentes : $INSTRUCTIONS"; afaire=$((afaire+1))
    elif ! grep -qxF -- "$MARQUE_DEBUT" "$INSTRUCTIONS"; then
        if grep -q 'Cairn' "$INSTRUCTIONS"; then
            echo "  instructions  présentes sans marqueurs : cairn.sh methode ne pourra pas les recalculer"
        else
            echo "  instructions  $INSTRUCTIONS ne parle pas de Cairn : voir adaptateurs/"; afaire=$((afaire+1))
        fi
    elif [ -f "$CACHE_METHODE/$ADAPTATEUR" ]; then
        ref=$(mktemp); bloc_de "$CACHE_METHODE/$ADAPTATEUR" > "$ref"
        dst=$(mktemp); bloc_de "$INSTRUCTIONS" > "$dst"
        if cmp -s "$ref" "$dst"; then echo "  instructions  bloc Cairn à jour"
        else echo "  instructions  bloc Cairn différent du dépôt en cache : cairn.sh methode"; fi
        rm -f "$ref" "$dst"
    else
        echo "  instructions  bloc Cairn présent (jamais comparé au dépôt : cairn.sh methode)"
    fi

    # Les skills.
    if [ -d "$SKILLS_METHODE" ]; then
        attendus=""
        if [ -d "$CACHE_METHODE/skill" ]; then attendus=$CACHE_METHODE/skill
        elif [ -d "$SOURCE/skill" ]; then attendus=$SOURCE/skill; fi
        if [ -n "$attendus" ]; then
            total=0; presents=0; manquants=""
            for d in "$attendus"/*/; do
                [ -d "$d" ] || continue
                total=$((total+1)); n=$(basename "$d")
                if [ -f "$SKILLS_METHODE/$n/SKILL.md" ]; then presents=$((presents+1)); else manquants="$manquants $n"; fi
            done
            if [ "$presents" = "$total" ]; then echo "  skills        $presents sur $total"
            else echo "  skills        $presents sur $total, manquants :$manquants"; afaire=$((afaire+1)); fi
        else
            echo "  skills        $(ls -d "$SKILLS_METHODE"/*/ 2>/dev/null | wc -l | tr -d ' ') installés (dépôt non disponible pour comparer)"
        fi
    else
        echo "  skills        aucun dossier de skills : $SKILLS_METHODE"
    fi

    # La méthode.
    if [ -f "$ETAT_METHODE" ]; then
        echo "  méthode       alignée sur le dépôt le $(cut -d' ' -f2 < "$ETAT_METHODE")"
    else
        echo "  méthode       jamais vérifiée : cairn.sh methode"
    fi

    # Les index et les projets.
    ecarts_total=0
    liste=$(mktemp)
    find "$racine" -name index.md -not -path "*/gabarits/*" -not -path "*/archive/*" 2>/dev/null > "$liste"
    while IFS= read -r i; do
        [ -n "$i" ] || continue
        index_dossier "$(dirname "$i")" 0 > /dev/null
        ecarts_total=$((ecarts_total + ecarts))
    done < "$liste"
    rm -f "$liste"
    if [ "$ecarts_total" = 0 ]; then echo "  index         à jour"
    else echo "  index         $ecarts_total écart(s) avec les en-têtes : cairn.sh index"; fi

    projets=$(contextes_de "$racine" | wc -l | tr -d ' ')
    vides=0
    contextes_de "$racine" > "$liste"
    while IFS= read -r c; do
        [ -n "$c" ] || continue
        grep -q 'Deux ou trois phrases' "$c" && vides=$((vides+1))
    done < "$liste"
    rm -f "$liste"
    if [ "$vides" = 0 ]; then echo "  projets       $projets, domaines : $(domaines_de "$racine")"
    else echo "  projets       $projets, dont $vides au contexte encore vide"; fi
    ligne_courant | sed 's/^- /  /'

    echo
    if [ "$afaire" = 0 ]; then echo "Rien ne manque."
    else echo "$afaire chose(s) à faire, la première en premier."; fi
    echo
}

[ $# -ge 1 ] || usage
commande=$1; shift
case "$commande" in
    aide)      cmd_aide "$@" ;;
    verifier)  cmd_verifier "$@" ;;
    init)      cmd_init "$@" ;;
    ou)        cmd_ou "$@" ;;
    installer) cmd_installer "$@" ;;
    groupe)    cmd_groupe "$@" ;;
    projet)    cmd_projet "$@" ;;
    index)     cmd_index "$@" ;;
    methode)   cmd_methode "$@" ;;
    ici)       echo "\"ici\" s'appelle désormais \"init\"." >&2; cmd_init "$@" ;;
    *)         usage ;;
esac
