#!/bin/sh

set -e

#which sha1sum
#which read

mkdir -p ~/.aws
touch ~/.aws/credentials

echo "[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" > ~/.aws/credentials

echo "Set IFS"
IFS=' '
echo "Get sha value"
VAL=`sha1sum ${FILE}`
echo $VAL > tmp
read SUM NAME < tmp
echo "Read done"
echo ${SUM}

aws s3 cp ${FILE} s3://${AWS_S3_BUCKET}/${DESTINATION}/latest.zip \
            --region ${AWS_REGION} $*
aws s3 cp ${FILE} s3://${AWS_S3_BUCKET}/${DESTINATION}/${SUM}.zip \
            --region ${AWS_REGION} $*

rm -rf ~/.aws
