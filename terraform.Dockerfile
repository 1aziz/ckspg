FROM alpine:3.13

ENV TERRAFORM_VERSION=0.14.4
ENV GOOGLE_CREDENTIALS=/home/gcp_cred.json

RUN apk add --update git bash openssh

RUN cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin

WORKDIR /home

CMD [ "terraform", "-v" ]