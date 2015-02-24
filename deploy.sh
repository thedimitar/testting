# deploy.sh
#!/bin/bash

SHA1=$1

# Deploy image to private images repo. 

echo thedpd | docker push thedpd/socketio

