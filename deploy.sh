# deploy.sh
#!/bin/bash

SHA1=$1

# Deploy image to Docker Hub

echo thedpd | docker push thedpd/api-peer

# Create new Elastic Beanstalk version
EB_BUCKET=peerbelt
DOCKERRUN_FILE=Dockerrun.aws.json
#sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE
aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE
aws elasticbeanstalk create-configuration-template --application-name peerbelt --template-name peerbelt-temp --options-file options.json
aws elasticbeanstalk create-environment  --application-name peerbelt -e TEST-$SHA1 -t peerbelt-temp
aws elasticbeanstalk create-application-version --application-name peerbelt --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name TEST-$SHA1 --version-label $SHA1
