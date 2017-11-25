#/bin/bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ROOT=$(cd $DIR && cd .. && pwd)
SECRETS=$(perl -ne 'print " --secret $1=$2" if (/^([^=]+)=(.*)$/);' ${ROOT}/.env)
# ag to list files, entr to restart on changes
ag -l | entr -r wt serve -p 8081 --parse-body ${DIR}/answer.js $SECRETS
