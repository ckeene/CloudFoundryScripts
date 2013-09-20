#!/bin/sh
# CLOUD FOUNDRY database refresh script
# This app causes a database service to be refreshed
# When the service is refreshed the db is deleted
# When the app is re-bound to the service, it initializes the db

# PROXY - comment out if not behind a firewall
export http_proxy=http://proxy.vmware.com:3128

# TARGET cloud for deployment
vmc target api.cloudfoundry.com

# LOGIN to cloud foundry account
vmc login --email foo@bar.com --passwd foobar

# DELETE-SERVICE stop existing service
vmc delete-service custpurchase

# CREATE-SERVICE start new service, bind to crmsimple app 
# Note that this re-starts app and re-initializes database
vmc create-service mysql --name custpurchase --bind crmsimple

# LOGOUT
vmc logout

