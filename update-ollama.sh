#!/bin/bash

read -p "Do you want to update/install docker?  y/n : " docker
read -p "Do you want to update/install ollama?  y/n : " ollama
read -p "Do you want to update/install Open-WebUI?  y/n : " openwebui

if ["${docker,}" == "y"]; then
    echo "installing/updating docker"
    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo "No changes to Docker made"
fi

if [ "${ollama,}" == "y" ]; then    
    echo "installing/reinstalling Ollama...."
    curl -fsSL https://ollama.com/install.sh | sh 
else
    echo "No changes to Ollama made"  
fi

if [ "${openwebui,}" == "y" ]; then 
    
    echo "instaling/Updating Open-WebUI...."
    docker stop open-webui
    docker rm -f open-webui
    docker pull ghcr.io/open-webui/open-webui:latest

    echo "starting Open-WebUI"
    docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:latest
    echo "You can now access open-webui via http://127.0.0.1:11434, http://{host_ip}:11434, or preconfigured proxy redirect"
    exit 1
else
    echo "No changes to Openwebui made"
fi 

exit 0