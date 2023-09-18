# Re
TIME=$(date --utc "+%Y%m%d_%H%M%SZ")

BACKUP_FILE="filename_$(TIME).sql"
DATABASE_NAME="<database-name>"

# Dump sql dump on server
pg_dump $DATABASE_NAME -U $DATABASE_NAME --format=plain > $BACKUP_FILE

# Copy file to AWS S3
S3_BUCKET=s3://<s3 bucket name>
S3_TARGET=$S3_BUCKET/$BACKUP_FILE

echo "Copying $BACKUP_FILE to $S3_TARGET"
aws s3 cp $BACKUP_FILE $S3_TARGET

#verify the backup was uploaded correctly
echo "Backup completed for $DATABASE_NAME"
BACKUP_RESULT=$(aws s3 ls $S3_BUCKET | tail -n 1)
echo "Latest S3 backup: $BACKUP_RESULT"

#clean up and delete the local backup file
rm $BACKUP_FILE
