# Locally build and test addons
#
# Reference:
# - https://developers.home-assistant.io/docs/add-ons/testing/
# - https://github.com/home-assistant/builder
#

IMAGE_NAME=somfy-personal

all: build run

build:
	docker build SomfyProtect2MQTT-personal --no-cache --build-arg BUILD_FROM="homeassistant/amd64-base:3.12" -t ${IMAGE_NAME}

run:
	# This won't run correctly unless the right login pass is in
	# options.json
	#
	#     oauthlib.oauth2.rfc6749.errors.MissingTokenError: (missing_token) Missing access token parameter.
	#
	# Without a local MQTT server on hostname 'host', the connection will
	# fail.
	#
	#     self.client.connect(config.get("host", "127.0.0.1"), config.get("port", 1883), 60)
	#     [...]
	#     socket.gaierror: [Errno -2] Name does not resolve
	#
	mkdir -p example
	jq .options SomfyProtect2MQTT-personal/config.json > example/options.json
	docker run  -it -v ${shell pwd}/example:/data:ro --entrypoint /bin/bash ${IMAGE_NAME}
