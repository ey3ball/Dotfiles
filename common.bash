#!/bin/bash

# Common util functions and configuration

BACKUP_DIR="/tmp"

# deploy_link( File_To_Deploy, Target_Path )
function deploy_link {
	echo ">> ${2} -> ${1}"
	if [ -f ${2} ]; then
		if [ -z "${BACKUP_DIR}" ]; then
			echo mv "${2}" "${2}.old"
		else
			echo mv "${2}" ${BACKUP_DIR}/$(basename ${2})
		fi
	else
		echo rm -f "${2}"
	fi

	echo ln -s ${DOTPATH}/${1} ${2}
}

