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
  cairn.sh init [chemin]              crée un cairn (par défaut ~/cairn)
  cairn.sh domaine <nom>              ajoute un domaine
  cairn.sh projet <domaine> <nom>     crée un projet et pose les 4 questions

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
     cairn.sh projet pro mon-premier-projet

Pour l'historique et la sauvegarde, un git init dans $racine est une bonne idée
dès maintenant : tout ce que vous ferez ensuite devient réversible.

TERMINE
}

cmd_domaine() {
    [ $# -eq 1 ] || usage
    nom=$1
    case "$nom" in
        commun|archive|gabarits)
            echo "\"$nom\" est un nom réservé." >&2; exit 1 ;;
    esac
    racine=$(cairn_racine)
    [ ! -d "$racine/$nom" ] || { echo "Le domaine $nom existe déjà." >&2; exit 1; }
    mkdir -p "$racine/$nom/_commun"
    printf '# Commun du domaine %s\n\n<!-- Ce qui vaut pour tous les projets de ce domaine. Une ligne par fichier. -->\n' \
        "$nom" > "$racine/$nom/_commun/index.md"
    echo "Domaine créé : $racine/$nom"
}

cmd_projet() {
    [ $# -eq 2 ] || usage
    domaine=$1 nom=$2
    racine=$(cairn_racine)

    [ -d "$racine/$domaine" ] || {
        echo "Le domaine $domaine n'existe pas. Créez-le : cairn.sh domaine $domaine" >&2
        exit 1
    }
    projet="$racine/$domaine/$nom"
    [ ! -d "$projet" ] || { echo "Le projet $nom existe déjà dans $domaine." >&2; exit 1; }

    # Le rituel d'ouverture. Une seule fois, à la création.
    echo
    echo "Quatre questions, une seule fois. Entrée accepte la valeur par défaut."
    echo

    printf 'Où se trouve le dossier de travail ? [aucun] : '
    read -r chemin || chemin=""
    [ -n "$chemin" ] || chemin="(aucun)"

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

    remplacer 'nom-stable-du-projet' "$nom"       "$projet/contexte.md"
    remplacer '^domaine: pro$'       "domaine: $domaine" "$projet/contexte.md"
    remplacer '^chemin: .*$'         "chemin: $chemin"   "$projet/contexte.md"
    remplacer '^capture: .*$'        "capture: $capture" "$projet/contexte.md"
    remplacer '^diffusion: .*$'      "diffusion: $diffusion" "$projet/contexte.md"
    remplacer '05/09/2026'           "$AUJOURDHUI"       "$projet/contexte.md"
    remplacer '05/09/2026'           "$AUJOURDHUI"       "$projet/journal.md"
    remplacer '# Nom du projet'      "# $nom"            "$projet/index.md"

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
    init)    cmd_init "$@" ;;
    domaine) cmd_domaine "$@" ;;
    projet)  cmd_projet "$@" ;;
    *)       usage ;;
esac
