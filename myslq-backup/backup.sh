#!/bin/sh
set -e

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="${MYSQL_DATABASE}_${TIMESTAMP}.sql.gz"
BACKUP_PATH="/tmp/backups/${FILENAME}"

mkdir -p /tmp/backups

echo "[$(date)] Starting backup: ${FILENAME}"

mysqldump \
  -h "${MYSQL_HOST}" \
  -P "${MYSQL_PORT}" \
  -u "${MYSQL_USER}" \
  -p"${MYSQL_PASSWORD}" \
  --single-transaction \
  --routines \
  --triggers \
  "${MYSQL_DATABASE}" | gzip > "${BACKUP_PATH}"

echo "[$(date)] Backup done, copying via SCP..."

scp -P "${SCP_PORT}" \
    -o StrictHostKeyChecking=no \
    -o BatchMode=yes \
    "${BACKUP_PATH}" \
    "${SCP_USER}@${SCP_HOST}:${SCP_TARGET_DIR}/${FILENAME}"

echo "[$(date)] SCP done, cleaning up old backups..."

# remove local files older than RETAIN_DAYS
find /tmp/backups -name "*.sql.gz" -mtime +${RETAIN_DAYS} -delete

echo "[$(date)] Done."

