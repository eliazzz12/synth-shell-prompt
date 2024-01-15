###########################################
# Script creado por Elías Martín González #
###########################################

# Variables

Directory=~/.config/synth-shell/examples
Prefix="synth-shell-prompt."
Suffix=".config"
NewSearch="Y"


# Funciones
function searchForFile(){
    if [ -f "$FILE" ];
    then
        cp $FILE .././synth-shell-prompt.config
        NewSearch="N"

    elif [ -f "${Prefix}${FILE}${Suffix}" ];
    then
        cp ${Prefix}${FILE}${Suffix} .././synth-shell-prompt.config
        NewSearch="N"
    
    else
        echo "Archivo no encontrado :("
        echo "¿Buscar de nuevo?"
        read -p "[Y/n]  " NewSearch
    fi
}
function searchWithParams(){
    if [ -f "$FILE" ];
    then
        cp $FILE .././synth-shell-prompt.config
        NewSearch="N"

    elif [ -f "${Prefix}${FILE}${Suffix}" ];
    then
        cp ${Prefix}${FILE}${Suffix} .././synth-shell-prompt.config
        NewSearch="N"

    else
        echo "Archivo no encontrado :("
        echo "Programa finalizado"
    fi
}
function choose(){
    echo
    echo "¿Que configuración quieres cargar?"
    echo
    ls
    echo
    echo "Puedes escribir el nombre entero u omitir el *$Prefix* y el *.config*"
    echo
    read -p "Archivo: " FILE
    echo
    searchForFile
}



####################################################################
# MAIN

# Situarse en el directorio de synth-shell

cd $Directory

# Comprobar si se ha pasado por parámetro algo o no

if [ -z "$1" ]
then
    while [ $NewSearch == 'Y' ] || [ $NewSearch == 'y' ]; do
        choose
    done
else
    FILE=$1
    searchWithParams
fi
