#/bin/bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DIR=/home/saneyan/Development/github.com/saneyan/junction2017-webtask/api
ROOT=$(cd $DIR && cd .. && pwd)
SECRETS=$(perl -ne 'print " --secret $1=$2" if (/^([^=]+)=(.*)$/);' ${ROOT}/.env)
wt create -p node8 ${DIR}/answer.js $SECRETS
