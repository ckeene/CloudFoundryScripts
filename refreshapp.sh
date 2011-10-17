#!/usr/bin/expect 
# CLOUD FOUNDRY app refresh script
# This shell script causes an app + bound database service to be refreshed
# Uses unix expect/send to handle interactive vmc calls

# DEBUGGING uncomment next line for debugging
# exp_internal 1

# TIMEOUT in seconds - 2 minutes seems to work well
set timeout 120

# TARGET cloud for deployment - wait for eof before spawning next activity
spawn vmc target api.cloudfoundry.com
expect eof

# LOGIN to cloud foundry account
spawn vmc login --email chris@ckeene.com --passwd c1keene
expect eof

# DELETE-SERVICE stop existing service
spawn vmc delete-service custpurchase
expect eof

# DELETE stop existing app
spawn vmc delete crmsimple
expect eof

# CREATE-SERVICE start new service
spawn vmc create-service mysql --name custpurchase
expect eof

# PUSH start new app, bind to service
spawn vmc push crmsimple --path /Users/ckeene/Documents/WaveMaker/projects/crmsimple/dist --url crmsimple.cloudfoundry.com --instances 1 --mem 512M 
expect "is this correct" {send y\r}
expect "bind any services" {send y\r}
expect "existing provisioned service" {send y\r}
expect "one you wish to provision" {send 1\r}
expect eof
