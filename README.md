# IoT-Hub-Alpha

Main umbrella repository for IoT-Hub microservices platform.

## Documentation

- [Microservices Repository Structure](docs/microservices-repository-structure.md)


## Envs
`/scripts/refresh.sh`
This script will refresh all envs both in root (`.env`) and in `/envs/`.

it will read *.env.example and create(or override) the corresponding .env file.

Please make sure to run this script after each main repo update to have the latest .env vars

## Simulator
simulator is located at `/simulator/`, please install its `requirements.txt` at `/simulator/requirements.txt`

Simulator works the same way as before, example usage:
```
python -m simulator.run -d device1 -v -m mqtt
```
from root directory.

## Main umbrella repo

Login through GitHub Access Token
```bash
docker login ghcr.io -u username
```

Go to microservice directory
```bash
cd your-cool-name-microservice
```

Build image for GHCR
```bash
ghcr.io/iot-hub-alpha/<image-name>:<tag>
```
Example
```bash
docker build -t ghcr.io/iot-hub-alpha/test-microservice:latest .
```

Better use tag version, instead latest, but you can create multiple tags
```bash
docker build \
-t ghcr.io/iot-hub-alpha/test-microservice:0.1 \
-t ghcr.io/iot-hub-alpha/test-microservice:latest \
.
```

Push image
```bash
docker push ghcr.io/iot-hub-alpha/test-microservice:tag
```

Ensure package created in github (Organization -> Packages)
```bash
https://github.com/orgs/iot-hub-alpha/packages
```

Use image in docker-compose
```bash
your-microservice:
  image: ghcr.io/iot-hub-alpha/your-microservice:tag
```

Use this if you want to test local
```bash
  build:
    context:
      ../test-microservice
```

Pull last image
```bash
docker compose pull
docker compose up
```
