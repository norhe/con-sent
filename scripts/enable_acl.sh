#! /bin/bash

echo "Giving consul cluster time to stabilize..."
sleep 30

#echo "Bootstrapping ACLs..."
#curl \
#    --request PUT \
#    http://127.0.0.1:8500/v1/acl/bootstrap

echo "Retrieving agent id..."
AGENT_ID=$(curl \
    --request PUT \
    --header "X-Consul-Token: abc123" \
    --data \
'{
  "Name": "Agent Token",
  "Type": "client",
  "Rules": "node \"\" { policy = \"write\" } service \"\" { policy = \"read\" }"
}' http://127.0.0.1:8500/v1/acl/create | jq .ID | tr -d '"')

echo "$AGENT_ID"  ~/agent_id

echo "Setting agent id..."
curl \
    --request PUT \
    --header "X-Consul-Token: abc123" \
    --data \
'{
  "Token": "$AGENT_ID"
}' http://127.0.0.1:8500/v1/agent/token/acl_agent_token
