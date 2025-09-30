docker buildx build --platform=linux/amd64 --build-arg ARCH=x64 --build-arg TAG=dev --progress=plain --output type=local,dest=build/x64 .
