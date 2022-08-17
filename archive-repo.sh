#/usr/bin/bash

set -e

if [ -z $GITLAB_TOKEN ]; then
  echo 'Error: $GITLAB_TOKEN must be set in order to archive the project in Gitlab'
  return
fi

GITLAB_PATH=$1
NAME=$(echo $GITLAB_PATH | sed 's/\//__/g')
ARCHIVE_PATH=/tmp/$NAME.tar.gz
REPOSITORY_PATH=/tmp/$NAME
PROJECT_PATH=$(echo "${GITLAB_PATH%.git}" |  sed 's/\//%2F/g')

echo $PROJECT_PATH

rm -rf $REPOSITORY_PATH
git clone --mirror ssh://git@git.vidispine.com:8081/$1 $REPOSITORY_PATH

rm -rf $ARCHIVE_PATH
tar -C /tmp -zcf $ARCHIVE_PATH $NAME

aws s3 mv $ARCHIVE_PATH s3://rnd-gitlab-archive/$NAME.tar.gz --profile temp

rm -rf $REPOSITORY_PATH $ARCHIVE_PATH

curl --request POST --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "http://git.vidispine.com/api/v4/projects/$PROJECT_PATH/archive"
