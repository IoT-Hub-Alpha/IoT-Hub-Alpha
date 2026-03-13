# IoT-Hub-Alpha

Main umbrella repository for IoT-Hub microservices platform.

## Documentation

- [Microservices Repository Structure](docs/microservices-repository-structure.md)

Main umbrella repo

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
