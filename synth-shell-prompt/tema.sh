###########################################
# Script creado por Elías Martín González #
###########################################

# Situarse en el directorio de synth-shell

cd "/.config/synth-shell"

# Preguntar qué config usar si no se ha pasado por parámetro

if [ ! -z "$1" ]
then
    echo "¿Que configuración quieres cargar?"
    ll
    echo "Puedes escribir el nombre entero o quitar *synth-shell-config*"
    read -p  FILE
fi


