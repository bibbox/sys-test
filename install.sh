#!/bin/bash
echo "Installing TestError"
echo "installing from $PWD"

clean_up() {	
	exit $1
}

error_exit()
{
	echo "ERROR in ${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	clean_up 1
}

updateConfigurationFile()
{
    echo "Creat and Update config files"
    if  [[ ! -f "$folder/docker-compose.yml" ]]; then
        cp docker-compose.yml "$folder/docker-compose.yml"
    fi
    
    sed -i "s/§§INSTANCE/${instance}/g" "$folder/docker-compose.yml"
    sed -i "s#§§FOLDER#${folder}#g" "$folder/docker-compose.yml"
}

createFolders()
{
    if [[ ! -d "$folder" ]]; then
        echo "Creating Installation Folder"
        mkdir -p "$folder"
    fi
}

while [ "$1" != "" ]; do
    case $1 in
        -i | --instance )       shift
                                instance=$1
                                ;;
        -f | --folder )         shift
                                folder=$1
                                ;;
        -p | --port )           shift
                                port=$1
                                ;;
                                * )                     usage
                                error_exit "Parameters not matching"
    esac
    shift
done

createFolders
updateConfigurationFile
