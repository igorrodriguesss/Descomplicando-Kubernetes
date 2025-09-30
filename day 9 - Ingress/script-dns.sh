#!/bin/bash
# update-duckdns.sh

DUCKDNS_TOKEN="2ec67dd4-4f4e-4fd9-a825-942ba89bb48b"
DOMAIN="giropops"
LB_HOSTNAME="a52eacafe19454f38bae6e43b7b96d18-df4e4065dd951a70.elb.us-east-1.amazonaws.com"

while true; do
    # Obter o IP atual do Load Balancer
    CURRENT_IP=$(dig +short $LB_HOSTNAME | head -1)
    
    # Obter o IP atual no DuckDNS
    DUCKDNS_IP=$(dig +short ${DOMAIN}.duckdns.org | head -1)
    
    # Comparar e atualizar se necessário
    if [ "$CURRENT_IP" != "$DUCKDNS_IP" ]; then
        echo "Updating DuckDNS: $CURRENT_IP"
        curl "https://www.duckdns.org/update?domains=${DOMAIN}&token=${DUCKDNS_TOKEN}&ip=${CURRENT_IP}"
    fi
    
    sleep 300  # Verificar a cada 5 minutos
done
