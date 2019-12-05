#!/bin/sh

# just wait a few seconds
sleep 5

# run mgrations
/migrate -path migrations $*
