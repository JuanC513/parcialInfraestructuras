#!/usr/bin/env bash
#
# Este script se encarga de invocar los tres programas que permiten la 
# conversion de un PNG a secuencia de pixeles, se procesan esos pixeles y
# posteriormente se convierte esa secuencia de pixeles a un archivo en formato
# PNG
#
# Autor: John Sanabria - john.sanabria@correounivalle.edu.co
# Fecha: 2024-08-22
#

# Ruta de la carpeta con las imágenes
IMAGE_DIR="./Images"

# Bucle sobre todos los archivos .png en la carpeta 
for image in ${IMAGE_DIR}/*.png
do
    # Definir variables INPUT_PNG y TEMP_FILE
    INPUT_PNG="${image}"
    TEMP_FILE="${INPUT_PNG%.png}.bin"

    # Obtenemos las dimensiones de la imagen
    dimensions=$(identify -format "%w %h" "${INPUT_PNG}")
    WIDTH=$(echo $dimensions | cut -d' ' -f1)
    HEIGHT=$(echo $dimensions | cut -d' ' -f2)
    
    # Ejecutar los comandos para cada imagen
    python3 fromPNG2Bin.py ${INPUT_PNG}
    ./main ${TEMP_FILE} ${WIDTH} ${HEIGHT}
    python3 fromBin2PNG.py ${TEMP_FILE}.new ${WIDTH} ${HEIGHT}

    echo "Procesado ${image} con ancho ${WIDTH} y alto ${HEIGHT}"
done

