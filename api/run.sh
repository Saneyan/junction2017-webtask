#/bin/bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ROOT=$(cd $DIR && cd .. && pwd)
SECRETS=$(perl -ne 'print " --secret $1=$2" if (/^([^=]+)=(.*)$/);' ${ROOT}/.env)
wt serve -p 8081 --parse-body ${DIR}/answer.js $SECRETS
