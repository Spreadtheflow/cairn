#!/bin/sh
# Cairn — méthode de mémoire pour assistants IA
# https://github.com/Spreadtheflow/cairn
#
# Ce script est un raccourci, pas la méthode. Tout ce qu'il fait peut se faire
# à la main : copier un dossier, copier un gabarit, remplir quelques lignes.

set -eu

SOURCE=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
AUJOURDHUI=$(date +%d/%m/%Y)

usage() {
    cat <<'USAGE'
Usage :
  cairn.sh init [chemin]           crée un cairn (par défaut ~/cairn)
  cairn.sh groupe <chemin>         ajoute un dossier de rangement avec son _commun
  cairn.sh projet <chemin>         crée un projet et pose les 4 questions

Les chemins sont relatifs à la racine du cairn, aussi profonds que voulu :
  cairn.sh groupe clients/orsay-mutuelle
  cairn.sh projet clients/orsay-mutuelle/audit-conformite

Le cairn utilisé est $CAIRN s'il est défini, sinon ~/cairn.
USAGE
    exit 1
}

cairn_racine() {
    racine=${CAIRN:-$HOME/cairn}
    if [ ! -d "$racine" ]; then
        echo "Pas de cairn dans $racine. Lancez d'abord : cairn.sh init" >&2
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

cmd_init() {
    racine=${1:-${CAIRN:-$HOME/cairn}}
    if [ -e "$racine" ]; then
        echo "$racine existe déjà. Rien n'a été touché." >&2
        exit 1
    fi
    mkdir -p "$racine"
    cp -R "$SOURCE/squelette/." "$racine/"
    cp -R "$SOURCE/gabarits" "$racine/gabarits"
    cp "$SOURCE/METHODE.md" "$SOURCE/DOCTRINE.md" "$racine/"

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

  3. Créez votre premier projet :
     cairn.sh projet pro/mon-premier-projet

Pour l'historique et la sauvegarde, un git init dans $racine est une bonne idée
dès maintenant : tout ce que vous ferez ensuite devient réversible.

TERMINE
}

cmd_groupe() {
    [ $# -eq 1 ] || usage
    chemin=$1
    case "$chemin" in
        commun|archive|gabarits|commun/*|archive/*|gabarits/*)
            echo "\"$chemin\" est un emplacement réservé." >&2; exit 1 ;;
        /*|*/../*|../*)
            echo "Donnez un chemin relatif à la racine du cairn." >&2; exit 1 ;;
    esac
    racine=$(cairn_racine)
    [ ! -d "$racine/$chemin" ] || { echo "$chemin existe déjà." >&2; exit 1; }
    [ ! -f "$racine/$chemin/contexte.md" ] || {
        echo "$chemin est un projet, pas un groupe." >&2; exit 1; }

    mkdir -p "$racine/$chemin/_commun"
    printf '# Commun de %s\n\n<!-- Ce qui vaut pour tout ce qui se trouve en dessous, et pas au-delà.\n     Une ligne par fichier. -->\n' \
        "$chemin" > "$racine/$chemin/_commun/index.md"
    echo "Groupe créé : $racine/$chemin"
}

cmd_projet() {
    [ $# -eq 1 ] || usage
    chemin=$1
    case "$chemin" in
        commun|archive|gabarits|commun/*|archive/*|gabarits/*)
            echo "\"$chemin\" est un emplacement réservé." >&2; exit 1 ;;
        /*|*/../*|../*)
            echo "Donnez un chemin relatif à la racine du cairn." >&2; exit 1 ;;
        */*) : ;;
        *)  echo "Un projet vit dans un domaine. Essayez : $chemin/quelque-chose" >&2
            exit 1 ;;
    esac
    racine=$(cairn_racine)
    projet="$racine/$chemin"
    nom=$(basename "$chemin")
    domaine=$(printf '%s' "$chemin" | cut -d/ -f1)

    [ ! -d "$projet" ] || { echo "$chemin existe déjà." >&2; exit 1; }

    # Un projet ne vit pas dans un autre projet.
    parent=$(dirname "$chemin")
    while [ "$parent" != "." ] && [ "$parent" != "/" ]; do
        if [ -f "$racine/$parent/contexte.md" ]; then
            echo "$parent est déjà un projet ; un projet n'en contient pas d'autre." >&2
            echo "Transformez-le en groupe : déplacez son contexte.md dans un sous-dossier." >&2
            exit 1
        fi
        parent=$(dirname "$parent")
    done

    # Le rituel d'ouverture. Une seule fois, à la création.
    echo
    echo "Quatre questions, une seule fois. Entrée accepte la valeur par défaut."
    echo

    printf 'Où se trouve le dossier de travail ? [aucun] : '
    read -r travail || travail=""
    [ -n "$travail" ] || travail="(aucun)"

    printf 'On capture de la mémoire ici ? (oui / non / a-la-demande) [oui] : '
    read -r capture || capture=""
    [ -n "$capture" ] || capture="oui"

    echo
    echo "Où pourra finir ce qui sera écrit ici ?"
    echo "  privee    ça reste chez moi. On écrit en clair, noms compris."
    echo "  partagee  ce sera remis à un client ou un collègue."
    echo "  publique  ça peut finir publié. On anonymise en écrivant."
    printf 'Diffusion ? [privee] : '
    read -r diffusion || diffusion=""
    [ -n "$diffusion" ] || diffusion="privee"

    mkdir -p "$projet"
    cp "$racine/gabarits/contexte.md" "$projet/contexte.md"
    cp "$racine/gabarits/journal.md"  "$projet/journal.md"
    cp "$racine/gabarits/index.md"    "$projet/index.md"

    remplacer 'nom-stable-du-projet' "$nom"                  "$projet/contexte.md"
    remplacer '^domaine: .*$'        "domaine: $domaine"     "$projet/contexte.md"
    remplacer '^chemin: .*$'         "chemin: $travail"      "$projet/contexte.md"
    remplacer '^capture: .*$'        "capture: $capture"     "$projet/contexte.md"
    remplacer '^diffusion: .*$'      "diffusion: $diffusion" "$projet/contexte.md"
    remplacer '05/09/2026'           "$AUJOURDHUI"           "$projet/contexte.md"
    remplacer '05/09/2026'           "$AUJOURDHUI"           "$projet/journal.md"
    remplacer '# Nom du projet'      "# $nom"                "$projet/index.md"

    echo
    echo "Projet créé : $projet"
    if [ "$capture" = "non" ]; then
        echo "Capture désactivée : rien ne sera retenu ici tant que vous ne changez"
        echo "pas cette ligne dans contexte.md."
    else
        echo "Complétez contexte.md, c'est ce qui sera lu en premier."
    fi
    echo
}

[ $# -ge 1 ] || usage
commande=$1; shift
case "$commande" in
    init)   cmd_init "$@" ;;
    groupe) cmd_groupe "$@" ;;
    projet) cmd_projet "$@" ;;
    *)       usage ;;
esac
