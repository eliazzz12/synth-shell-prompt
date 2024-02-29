###########################################
# Script creado por Elías Martín González #
###########################################

# Este código permite elegir un archivo y copiarlo a otra carpeta sobreescribiendo el archivo de configuración (synth-shell-prompt.config).
# Con esto se consigue cambiar la configuración que usar el programa synth-shell-prompt para modificar el prompt.

# Variables para definir:
# -La carpeta en la que están los archivos necesarios para que funcione el código.
# -El prefijo y el sufijo del nombre de los archivos de configuración.
# -Inicializar la variable para realizar una nueva búsqueda.

Directory=~/.config/synth-shell/examples
Prefix="synth-shell-prompt."
Suffix=".config"
NewSearch="Y"


# Funciones
# Esta función comprueba si la variable FILE contiene el nombre de un archivo existente y si es así lo sobreescribre
# por encima del archivo de configuración (synth-shell-prompt.config).
# Si no encuentra el archivo permite realizar una nueva búsqueda.
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

# Esta función hace la misma función que searchForFile() pero si no encuentra el archivo
# lo notifica al usuario y termina.
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

# Esta función muestra al usuario los archivos de configuración y lee el archivo a utilizar,
# permite la busqueda usando el nombre completo o solo la parte diferente del resto de archivos.
function choose(){
    echo
    echo "¿Que configuración quieres cargar?"
    echo
    ls
    echo
    echo "Puedes escribir el nombre entero u omitir el *$Prefix* y el *$Suffix*"
    echo
    read -p "Archivo: " FILE
    echo
    searchForFile
}

####################################################################
# MAIN
# El código si no recibe parámetros hará la función choose()
# Si recibe parámetros hará la busqueda directamente,
# tras ello actualiza el archivo del que linux lee la configuración del prompt


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
