#!/bin/bash

# Common util functions and configuration

BACKUP_DIR="/tmp"

# deploy_link( File_To_Deploy, Target_Path )
function deploy_link {
	echo ">> ${2} -> ${1}"

	if [ -f ${2} ]; then
		if [ -z "${BACKUP_DIR}" ]; then
			mv "${2}" "${2}.old"
		else
			mv "${2}" ${BACKUP_DIR}/$(basename ${2})
		fi
	else
		# rm old link otherwise
		rm -f "${2}"
	fi

        if [ ! -d $(dirname $2) ]; then
                mkdir -p $(dirname $2)
        fi

	ln -s ${DOTPATH}/${1} ${2}
}

