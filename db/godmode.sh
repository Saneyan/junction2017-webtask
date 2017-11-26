#/bin/bash
if [ -z $1 ]; then echo "provide action (create / remove / seed / browse)"; exit; fi

ACTION=$1
STAGE=$2

DIR=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd $DIR && cd .. && pwd)

if [ "$ACTION" = "remove" ]; then
  read -p "Are you sure? Database will be dropped. (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit; fi
fi

. ${ROOT}/.env

# read from env if available
DB_HOST=$PGHOST
DB_NAME=$PGDATABASE
DB_USER=$PGUSER
DB_PASS=$PGPASSWORD
DB_PORT=$PGPORT

if [ "$ACTION" = "remove" ]; then
  C1="drop owned by $DB_USER;"
fi

if [ "$ACTION" = "create" ]; then
  C1=$(<$DIR/schema.sql)
fi

if [ "$ACTION" = "seed" ]; then
  C1=$(<$DIR/seed.sql)
fi

docker run -it --rm postgres env PGPASSWORD=$DB_PASS psql -p $DB_PORT -h $DB_HOST -U $DB_USER $DB_NAME -c "$C1"

if [ "$ACTION" = "browse" ]; then
  docker run -it --rm postgres env PGPASSWORD=$DB_PASS psql -h $DB_HOST -p $DB_PORT -U $DB_USER $DB_NAME
fi
