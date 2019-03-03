# Define constants
IMAGE_NAME?=m0rf30/arch-yay:latest

all: build

build:
	docker build -t=$(IMAGE_NAME) .

run:
	docker run -it --rm $(IMAGE_NAME) /bin/bash
