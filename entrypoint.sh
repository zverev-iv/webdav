#!/bin/sh

if [ -e /htpasswd ]; then exit 0; fi

if [ -n "$USERNAME" ]
then
  htpasswd -bc /htpasswd $USERNAME $PASSWORD
  echo "Single user added successfully!"
  exit 0
fi

echo "Error! Check user is configured correctly."
exit 1