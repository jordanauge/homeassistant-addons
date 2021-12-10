ARG BUILD_FROM
FROM $BUILD_FROM
ENV LANG C.UTF-8

# SomfyProtect2MQTT version
ARG VERSION=0.1.4

# Install required packages
RUN apk add --no-cache py3-pip git
RUN pip3 install python-json2yaml oauthlib requests_oauthlib
RUN pip3 install git+https://github.com/jordanauge/somfy-protect-api

# Download sources from git
WORKDIR /usr/src
RUN git clone https://github.com/jordanauge/SomfyProtect2MQTT

# Install python requirements
WORKDIR /usr/src/SomfyProtect2MQTT/somfyProtect2Mqtt
RUN pip3 install -r requirements.txt

# Run script
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
