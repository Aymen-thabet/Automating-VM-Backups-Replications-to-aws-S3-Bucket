#!/bin/bash

time=$(date +"%Y-%m-%d_%H-%M-%S")
backup_file=/home/aymen/bash
Dest=/home/aymen/backup
filename=file-backup-$time.tar.gz
LOG_FILE="/home/aymen/backup/logfile.log"
S3_BUCKET="myxdbucketlol"
FILE_TO_UPLOAD="$Dest/$filename"

mkdir -p "$(dirname "$LOG_FILE")"

if ! command -v aws &> /dev/null
then
    echo "AWS CLI not installed! Please install it first :)" | tee -a "$LOG_FILE"
    exit 2
fi

if [ -f "$FILE_TO_UPLOAD" ]
then
    echo "Error: file $filename already exists" | tee -a "$LOG_FILE"
else
    tar -czvf "$FILE_TO_UPLOAD" "$backup_file"
    if [ $? -eq 0 ];  
        then
        echo "Backup completed successfully. Backup file: $FILE_TO_UPLOA#D" | tee -a "$LOG_FILE"

        aws s3 cp "$FILE_TO_UPLOAD" "s3://$S3_BUCKET"
        if [ $? -eq 0 ]; then
            echo "File uploaded successfully to the S3 BUCKET: $S3_BUCKET" | tee -a "$LOG_FILE"
        else
            echo "FILE UPLOAD FAILED!" | tee -a "$LOG_FILE"
        fi
    else
        echo "Backup failed!" | tee -a "$LOG_FILE"
    fi
fi

