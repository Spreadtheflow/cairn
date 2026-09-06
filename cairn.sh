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

usage() {
    cat <<'USAGE'
Usage :
  cairn.sh aide                    rappelle comment ça marche, et l'état du cairn
  cairn.sh init [chemin]           rattache le DOSSIER COURANT à un projet du cairn
  cairn.sh ou                      dit à quel projet le dossier courant est rattaché
  cairn.sh installer [chemin]      crée le cairn lui-même (une fois, par défaut ~/cairn)
  cairn.sh groupe <chemin>         ajoute un dossier de rangement avec son _commun
  cairn.sh projet <chemin>         crée un projet sans se placer dans son dossier
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
remplacer() {
    motif=$1 valeur=$2 fichier=$3
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

cmd_installer() {
    racine=${1:-${CAIRN:-$HOME/cairn}}
    if [ -e "$racine" ]; then
        echo "$racine existe déjà. Rien n'a été touché." >&2
        exit 1
    fi
    mkdir -p "$racine"
    cp -R "$SOURCE/squelette/." "$racine/"
    cp -R "$SOURCE/gabarits" "$racine/gabarits"
    cp "$SOURCE/METHODE.md" "$SOURCE/DOCTRINE.md" "$SOURCE/AIDE.md" "$racine/"
    if command -v git >/dev/null 2>&1 && [ -d "$SOURCE/.git" ]; then
        noter_source "$(git -C "$SOURCE" rev-parse HEAD)"
    fi

    for f in "$racine/commun/profil.md" "$racine/commun/regles.md"; do
        remplacer '05/09/2026' "$AUJOURDHUI" "$f"
    done

    cat <<TERMINE

Cairn créé dans $racine

Trois choses à faire, dans cet ordre :

  1. Remplissez $racine/commun/profil.md
     C'est ce qui sera lu au début de chaque session.

  2. Branchez votre assistant.
     Voir adaptateurs/ dans le dépôt de la méthode.

  3. Placez-vous dans un dossier de travail et lancez :
     cairn.sh init

Pour revoir comment ça marche à tout moment : cairn.sh aide

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

# Cherche le projet dont le chemin de travail contient le dossier donné.
resoudre() {
    racine=$(cairn_racine)
    cible=$1
    if [ -f "$cible/.cairn" ]; then
        sed -n 's/^projet: *//p' "$cible/.cairn" | head -1
        return
    fi
    # Le chemin le PLUS SPÉCIFIQUE gagne : un projet déclaré sur un dossier large
    # (une racine, un home) ne doit pas avaler les projets rangés en dessous.
    meilleur=""; longueur=0
    for c in $(find "$racine" -name contexte.md -not -path "*/gabarits/*" 2>/dev/null); do
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
    done
    [ -n "$meilleur" ] && printf '%s' "$meilleur"
    return 0
}

# Chemin de travail declare par un projet du cairn.
chemin_de() {
    racine=$(cairn_racine)
    sed -n 's/^chemin: *//p' "$racine/$1/contexte.md" 2>/dev/null | head -1
}

cmd_aide() {
    racine=$(cairn_racine)
    if [ -f "$racine/AIDE.md" ]; then
        cat "$racine/AIDE.md"
    else
        echo "AIDE.md est absent du cairn." >&2
        echo "Récupérez-le sur https://github.com/Spreadtheflow/cairn" >&2
    fi
    domaines=$(find "$racine" -maxdepth 1 -mindepth 1 -type d -not -name '.*' \
        -not -name commun -not -name archive -not -name gabarits -not -name a-trier \
        -exec basename {} \; 2>/dev/null | sort | tr '\n' ' ')
    projets=$(find "$racine" -name contexte.md -not -path "*/gabarits/*" 2>/dev/null | wc -l | tr -d ' ')
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
    trouve=$(resoudre "$(pwd)")
    if [ -n "$trouve" ]; then
        echo "- dossier courant rattaché à : $trouve"
    else
        echo "- dossier courant : non rattaché (cairn.sh init pour le rattacher)"
    fi
    echo
}

cmd_ou() {
    ici=$(pwd)
    trouve=$(resoudre "$ici")
    if [ -n "$trouve" ]; then
        racine=$(cairn_racine)
        echo "$ici"
        echo "  rattaché à : $trouve"
        echo "  mémoire    : $racine/$trouve"
    else
        echo "$ici n'est rattaché à aucun projet du cairn."
        echo "Pour le rattacher : cairn.sh init"
    fi
}

cmd_init() {
    ici=$(pwd)
    racine=$(cairn_racine)

    deja=$(resoudre "$ici")
    if [ -n "$deja" ]; then
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
        echo "Domaines existants : $(find "$racine" -maxdepth 1 -mindepth 1 -type d -not -name '.*' \
            -not -name commun -not -name archive -not -name gabarits -not -name a-trier -exec basename {} \; | tr '\n' ' ')"
        printf 'Chemin du projet dans le cairn (ex. clients/machin/site) : '
        read -r chemin || chemin=""
        [ -n "$chemin" ] || { echo "Annulé." >&2; exit 1; }
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
# La méthode se recalcule, la mémoire jamais.
#
# Un cairn installé contient des copies du dépôt : METHODE.md, DOCTRINE.md,
# AIDE.md, les gabarits, les skills, et ce script. Ce sont des dérivés, et un
# dérivé ne se maintient pas, il se recalcule. Cette commande est le recalcul.
#
# Elle ne touche jamais commun/, ni un projet, ni un journal, ni un contexte.md.
# Ces fichiers-là n'ont pas de source ailleurs : ils sont la mémoire.
# ---------------------------------------------------------------------------

DEPOT_METHODE=${CAIRN_DEPOT:-https://github.com/Spreadtheflow/cairn.git}
CACHE_METHODE="${XDG_CACHE_HOME:-$HOME/.cache}/cairn-methode"
ETAT_METHODE="${XDG_STATE_HOME:-$HOME/.local/state}/cairn/methode-source"
SKILLS_METHODE=${CAIRN_SKILLS:-$HOME/.claude/skills}

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
    for f in METHODE.md DOCTRINE.md AIDE.md; do
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

# ajour, absent, retard (la copie est restée à la version notée), ou modifie.
etat_fichier() {
    ref="$CACHE_METHODE/$1"; dst=$2
    [ -f "$ref" ] || { echo inconnu; return; }
    [ -f "$dst" ] || { echo absent; return; }
    cmp -s "$ref" "$dst" && { echo ajour; return; }
    base=$(source_notee)
    if [ -n "$base" ] && git -C "$CACHE_METHODE" cat-file -e "$base:$1" 2>/dev/null; then
        tmp=$(mktemp)
        git -C "$CACHE_METHODE" show "$base:$1" > "$tmp" 2>/dev/null || true
        if cmp -s "$tmp" "$dst"; then rm -f "$tmp"; echo retard; return; fi
        rm -f "$tmp"
    fi
    echo modifie
}

# Copie en passant par un temporaire : ce script peut être sa propre cible.
poser() {
    # Écrire à travers un lien, jamais le remplacer.
    dst=$2; tours=0
    while [ -L "$dst" ] && [ "$tours" -lt 10 ]; do
        cible=$(readlink "$dst")
        case "$cible" in
            /*) dst=$cible ;;
            *)  dst=$(dirname "$dst")/$cible ;;
        esac
        tours=$((tours + 1))
    done
    set -- "$1" "$dst"
    mkdir -p "$(dirname "$2")"
    tmp="$2.cairn-tmp.$$"
    cp "$1" "$tmp"
    [ -x "$2" ] && chmod +x "$tmp"
    mv "$tmp" "$2"
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

    ajour=0 retard=0 modifie=0 absent=0 pose=0 laisse=0
    echo
    echo "Méthode : dépôt à $(git -C "$CACHE_METHODE" rev-parse --short HEAD), $DEPOT_METHODE"
    [ -n "$(source_notee)" ] || echo "Aucune version notée : ce qui diffère est signalé, jamais supposé en retard."
    echo
    while IFS='|' read -r src dst; do
        [ -n "$src" ] || continue
        case $(etat_fichier "$src" "$dst") in
            ajour)  ajour=$((ajour+1)) ;;
            absent) absent=$((absent+1))
                    echo "  absent               $dst"
                    [ "$appliquer" = 1 ] && { poser "$CACHE_METHODE/$src" "$dst"; pose=$((pose+1)); } ;;
            retard) retard=$((retard+1))
                    echo "  en retard            $dst"
                    [ "$appliquer" = 1 ] && { poser "$CACHE_METHODE/$src" "$dst"; pose=$((pose+1)); } ;;
            modifie) modifie=$((modifie+1))
                    echo "  modifié sur place    $dst"
                    if [ "$forcer" = 1 ]; then
                        cp "$dst" "$dst.avant-maj"
                        poser "$CACHE_METHODE/$src" "$dst"; pose=$((pose+1))
                        echo "                       ancienne version gardée en $dst.avant-maj"
                    else
                        laisse=$((laisse+1))
                    fi ;;
        esac
    done < "$liste"
    rm -f "$liste"

    echo
    echo "  à jour $ajour, en retard $retard, modifié sur place $modifie, absent $absent"
    echo
    if [ "$appliquer" = 1 ]; then
        echo "$pose fichier(s) posé(s)."
        [ "$laisse" = 0 ] || echo "$laisse laissé(s) : modifiés sur place. --forcer les écrase, en gardant une copie."
    elif [ $((retard + absent)) -gt 0 ]; then
        echo "cairn.sh methode --appliquer pour aligner ce qui est en retard ou absent."
    elif [ "$modifie" -gt 0 ]; then
        echo "Rien en retard. Ce qui diffère a été modifié sur place : à reporter dans le dépôt, ou à écraser avec --forcer."
    else
        echo "Tout est à jour."
    fi
    # On ne note la version que si le disque lui correspond vraiment : sinon la
    # passe suivante prendrait un retard pour une modification locale.
    if [ "$appliquer" = 1 ]; then
        [ "$laisse" = 0 ] && noter_source "$tete"
    else
        [ $((retard + absent + modifie)) -eq 0 ] && noter_source "$tete"
    fi
    echo
}

[ $# -ge 1 ] || usage
commande=$1; shift
case "$commande" in
    aide)      cmd_aide "$@" ;;
    init)      cmd_init "$@" ;;
    ou)        cmd_ou "$@" ;;
    installer) cmd_installer "$@" ;;
    groupe)    cmd_groupe "$@" ;;
    projet)    cmd_projet "$@" ;;
    methode)   cmd_methode "$@" ;;
    ici)       echo "\"ici\" s'appelle désormais \"init\"." >&2; cmd_init "$@" ;;
    *)         usage ;;
esac
