# Define constants
IMAGE_NAME?=m0rf30/arch-yay:latest

all: build

build:
	docker build -t=$(IMAGE_NAME) .

bash:
	docker run -it --rm $(IMAGE_NAME) /bin/bash

publish: build
	bash publish.sh $(IMAGE_NAME) $(VERSION)
