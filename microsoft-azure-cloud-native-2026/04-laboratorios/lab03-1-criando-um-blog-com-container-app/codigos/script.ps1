docker build -t blog-mgst-app:latest .

#detached mode". 
# Quando você usa essa opção, o container é executado em segundo plano (background) e o 
# terminal não fica "preso" ao processo do container. Ele retorna apenas o ID do container iniciado.


docker run -d -p 80:80 blog-mgst-app:latest

az login az l

# Create a resource group
az group create --name LAB003 --location eastus

# Create Container Registry
az acr create --resource-group LAB003 --name acrblogmgst --sku Basic

# Login to ACR
az acr login --name acrblogmgst

# Tag the image
docker tag blog-mgst-app:latest acrblogmgst.azurecr.io/blog-mgst-app:latest

# Push the image
docker push acrblogmgst.azurecr.io/blog-mgst-app:latest

#containerID = acrblogmgst.azurecr.io/blog-mgst-app:latest
#user =  userlogin
#password = password

# Create Environment container app
az containerapp env create  --name blog-mgst-env --resource-group LAB003 --location eastus2 

# Create Container App
az containerapp create --name blog-mgst-app --resource-group LAB003 --image acrblogmgst.azurecr.io/blog-mgst-app:latest --environment blog-mgst-env --target-port 80 --ingress external --registry-username login --registry-password password --registry-server acrblogmgst.azurecr.io


# az containerapp create \
# --name blog-henrique-app \
# --resource-group LAB003 \
# --location eastus \
# --image acrblogmgst.azurecr.io/blog-mgst-app:latest \
# --environment blog-mgst-env \
# --target-port 80 \ 
# --ingress external
# --registry-username login
# --registry-password password
# --registry-server acrblogmgst.azurecr.io


