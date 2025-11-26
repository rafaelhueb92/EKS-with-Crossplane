#!/bin/bash

# Variables
DOMAIN_NAME="eks.express.com"  # Change this to your domain name
CALLER_REFERENCE=$(date +%s)  # Unique identifier for this request
COMMENT="Hosted zone for ${DOMAIN_NAME}"  # Optional comment

# Create the hosted zone
aws route53 create-hosted-zone \
    --name "${DOMAIN_NAME}" \
    --caller-reference "${CALLER_REFERENCE}" \
    --hosted-zone-config Comment="${COMMENT}"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Hosted zone created successfully for ${DOMAIN_NAME}"
else
    echo "Failed to create hosted zone"
    exit 1
fi