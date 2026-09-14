#! /bin/bash


<<readme 
this is the script for take a logs from the aregument


readme

function display_usage {

	echo " usages :.backup.sh <path to your soures > <path to backup folder>"

}

if [ $# -eq 0 ]; then

	display_usage
	
fi


#taking backups

#funtions for backups

source_dir=$1
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
backup_dir=$2

function create_backup {
       
	
	zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null
	
	if [ $? -eq 0 ]; then
	
	       echo " backup generated successfuly for ${timestamp}"
	fi
}


#funtions perform rotation

function perform_rotation {

	backups=($(ls -t  "${backup_dir}/backup_"*.zip 2>/dev/null))

	

	if [ "${#backups[0]}" -gt 7 ]; then
		echo " performing rotation for 7days"
	
         
          	backups_to_remove=("${backups[@]:7}")
	        

		 for backup in "${backups_to_remove[@]}"
		 do 
			 rm -f ${backup}
		 done
	fi

}




create_backup 
perform_rotation

