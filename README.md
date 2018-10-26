# Docker Mysql Backup

Extreemly simple Mysql backup container that simply dumps all Mysql databases to a file on a cron schedule.

## Usage

```
docker run -v backup-volume:/backup kadimasolutions/mysql-backup
```

The backup will be written to `/backup/db-backup.sql.gz`. Backups will be run on the `CRON_SCHEDULE` and will replace the previously taken backup at each run.

## Environment Variables

### `CRON_SCHEDULE`

*Default:* `0 0 * * *`

### `INIT_BACKUP`

Set to `true` to do a backup when the container is started.

*Default:* `false`

### `MYSQL_HOST`

*Default:* mysql

### `MYSQL_PORT`

*Default:* `3306`

### `MYSQL_USER`

*Default:* `root`

### `MYSQL_PASSWORD`

*Default:* `password`
