# docker-pigen

A docker image to run https://github.com/RPi-Distro/pi-gen
Images available at https://hub.docker.com/repository/docker/kormoc/pigen

## Default layout

 * `/work` - Temporary build data resides here
 * `/deploy` - Built images end up here
 * `/config` - File to overwrite with any custom build settings

# Building rasbian

```
docker run --platform linux/arm64 --privileged --rm -it --mount type=bind,consistency=delegated,source=$(pwd)/deploy,target=/deploy --mount type=bind,consistency=delegated,source=$(pwd)/config,target=/config kormoc/pigen:latest
```

# Using locally

## Building the container locally

```
git clone https://github.com/kormoc/docker-pigen.git
cd docker-pigen

docker buildx create --name builder
docker buildx use builder
docker buildx inspect --bootstrap
docker buildx build --platform linux/arm64 . --tag pigen:latest --load
```

## Running the build

```
docker run --platform linux/arm64 --privileged --rm -it --mount type=bind,consistency=delegated,source=$(pwd)/deploy,target=/deploy --mount type=bind,consistency=delegated,source=$(pwd)/config,target=/config pigen:latest
```

This will give you the build in $(pwd)/deploy

## Notes

 * `--platform linux/arm64` is required to avoid the need for the host kernel to support `binfmt_misc`. This allows building on OS X x86
 * `--privileged` is required to bind mount in the build process
