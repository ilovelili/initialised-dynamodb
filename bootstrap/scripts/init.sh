#!/usr/bin/env bash

awslocal --endpoint-url=http://localhost:8000 dynamodb create-table --table-name Test --attribute-definitions AttributeName=Code,AttributeType=S AttributeName=Timestamp,AttributeType=N --key-schema AttributeName=Code,KeyType=HASH AttributeName=Timestamp,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1