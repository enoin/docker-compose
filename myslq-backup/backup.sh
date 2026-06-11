#!/usr/bin/env bash

set -euo pipefail

: "${RETAIN_DAYS:?RETAIN_DAYS not set}"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="${MYSQL_DATABASE}_${TIMESTAMP}.sql.gz"
BACKUP_PATH="/tmp/backups/${FILENAME}"

mkdir -p /tmp/backups

notify() {
  echo "notify..."
  echo "$TEAMS_WEBHOOK_URL"
  [ -z "${TEAMS_WEBHOOK_URL:-}" ] && return 0

  STATUS="$1"
  MSG="${STATUS} on $(hostname) at $(date)"

  echo "Sending Teams notification..."

  PAYLOAD=$(cat <<EOF
{
  "type": "AdaptiveCard",
  "\$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
  "version": "1.2",
  "body": [
    {
      "type": "TextBlock",
      "text": "Backup Status",
      "weight": "Bolder",
      "size": "Medium"
    },
    {
      "type": "TextBlock",
      "text": "${STATUS}",
      "wrap": true
    },
    {
      "type": "TextBlock",
      "text": "File: ${FILENAME}",
      "wrap": true,
      "isSubtle": true
    }
  ]
}
EOF
)

  curl -v -X POST "$TEAMS_WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD"

}

trap 'notify "❌ Backup FAILED"' ERR

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

gzip -t "${BACKUP_PATH}"

echo "[$(date)] Backup done, copying via SCP..."

ssh -p "${SCP_PORT}" \
  -o StrictHostKeyChecking=no \
  "${SCP_USER}@${SCP_HOST}" \
  "mkdir -p '${SCP_TARGET_DIR}'"

for i in 1 2 3; do
  scp -P "${SCP_PORT}" \
    -o StrictHostKeyChecking=no \
    -o BatchMode=yes \
    "${BACKUP_PATH}" \
    "${SCP_USER}@${SCP_HOST}:${SCP_TARGET_DIR}/${FILENAME}" && break
  echo "SCP failed, retry $i..."
  sleep 5
done

echo "[$(date)] SCP done, cleaning up old backups..."

find /tmp/backups -name "*.sql.gz" -mtime +"${RETAIN_DAYS}" -delete

echo "[$(date)] Done."

notify "Backup succeeded.."
