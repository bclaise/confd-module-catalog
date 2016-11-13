curl -v -H "Content-Type: application/vnd.yang.data+json" \
     -T ${FILE} \
     -u ${USERNAME}:${PASSWORD} \
     -X PATCH http://localhost:8008/api/running/organizations
