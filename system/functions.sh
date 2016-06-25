#
# UTILITY FUNCTIONS
#

### PATH VARIABLES
GISLAB_PATH_ADMIN="$GISLAB_ROOT/admin"
GISLAB_PATH_CUSTOM="$GISLAB_ROOT/custom"
GISLAB_PATH_SECRET="$GISLAB_ROOT/secret"
GISLAB_PATH_SYSTEM="$GISLAB_ROOT/system"
GISLAB_PATH_STORAGE="/storage"


### FUNCTIONS
gislab_info () {
    # print informative message
    m=$(echo $1 | sed "s/\n//g")

    tput bold
    echo -e "${m}." | fold -s | sed "s/^/[GIS.lab]: /g"
    tput sgr0
}


gislab_success () {
    # print success message
    m=$(echo $1 | sed "s/\n//g")

    tput bold
    tput setaf 2
    echo -e "${m}." | fold -s | sed "s/^/[GIS.lab]: /g"
    tput sgr0
}


gislab_warning () {
    # print warning message
    m=$(echo $1 | sed "s/\n//g")

    tput bold
    tput setaf 5
    echo -e "${m}!" | fold -s | sed "s/^/[GIS.lab]: /g"
    tput sgr0
}


gislab_error () {
    # print error message
    m=$(echo $1 | sed "s/\n//g")

    tput bold
    tput setaf 1
    echo -e "${m}!" | fold -s | sed "s/^/[GIS.lab]: /g"
    tput sgr0

    exit 1
}


gislab_require_root () {
    # exit if user is not root
    if [[ $EUID -ne 0 ]]; then
        gislab_error "This command can only be be run with superuser privileges"
        exit 1
    fi
}

# vim: set ts=8 sts=4 sw=4 et:
