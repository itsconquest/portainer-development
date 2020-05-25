# portainer-development
Version controlled codebase for building the `wconquest/dev` image, used for running the Portainer development environment inside a Docker container.

## How to use the existing image on DockerHub:
1. Git clone the Portainer repo `git clone https://github.com/portainer/portainer.git`
2. Move to the Portainer repo context `cd portainer`
3. Run the dev container `docker run -d -p 9000:9000 -v app:/src/portainer/app wconquest/dev`
4. The UI will now be served on port 9000. Any changes made inside the local /app directory on your machine will be reflected in the UI when the webpage is refreshed.

## If you prefer to build your own image using this repository:

1. Git clone this repo `git clone https://github.com/itsconquest/portainer-development.git`
2. Move to the repo context `cd portainer-development`
3. Build the image`docker build -t <IMAGE> -f dev.Dockerfile .` replacing `<IMAGE>` with the image name you want 
