#!/bin/bash

backup_cmd="mysqldump --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASSWORD --all-databases \
            | gzip > /backup/db-backup.sql.gz"

echo "#!/bin/bash" > /run-backup.sh
echo "$backup_cmd" > /run-backup.sh
chmod 744 /run-backup.sh

if [ "$INIT_BACKUP" = "true" ]; then
    echo "Running Init Backup"
    bash /run-backup.sh
    echo "Done"
fi

# Create cron job
echo "$CRON_SCHEDULE /run-backup.sh" > /cron-jobs.txt

# Start Cron
exec supercronic /cron-jobs.txt

