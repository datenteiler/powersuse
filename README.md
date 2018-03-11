# PowerSUSE -- a Docker container with openSUSE and PowerShell

## Build Docker image:

    docker build -t powersuse .
    
Run Container

    docker run -it --rm powersuse pwsh
    
Or pull it:

    docker pull datenteiler/powersuse
    docker run --name=powersuse -it datenteiler/powersuse pwsh

## Docker und VS Code:

Launch VS Code Quick Open (Ctrl+P), paste the following command, and press enter:

    ext install PeterJausovec.vscode-docker

By default, Docker runs as the root user on Linux. The extension does not assume root access, so you will need to create group called "docker" and add your user to it:

Add the docker group if it doesn't already exist:

    sudo groupadd docker

Add the connected user "$USER" to the docker group. Change the user name to match your preferred user if you do not want to use your current user:

    sudo gpasswd -a $USER docker

Either do a newgrp docker or log out/in to activate the changes to groups. You can use

    docker run hello-world

to check if you can run docker without sudo.

## Sometimes useful

One liner to stop / remove all of Docker containers:
    
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    
    
