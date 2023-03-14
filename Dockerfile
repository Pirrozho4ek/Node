FROM golang:alpine AS build-env

# Set up dependencies
ENV PACKAGES git build-base

# Set working directory for the build
WORKDIR /go/src/github.com/Entangle-Protocol/entangle-blockchain

# Install dependencies
RUN apk add --update $PACKAGES
RUN apk add linux-headers

RUN apk add go
RUN apk add make

# ARG key_password
ARG key_path=./keys

RUN echo key path $key_path
RUN echo ${key_path}
RUN echo COPY ${key_path} /

# RUN if [[ -n "$key_path" ]] ; then COPY ./$key_path /; fi

# Add source files
COPY . .

# Make the binary
RUN make build

# Final image
FROM alpine:3.16.2

# Install ca-certificates
RUN apk add --update ca-certificates jq
WORKDIR /

# Copy over binaries from the build-env
COPY --from=build-env /go/src/github.com/Entangle-Protocol/entangle-blockchain/build/entangled /usr/bin/entangled

# RUN yes key_password | entangled keys add validator_key --keyring-backend file --algo eth_secp256k1 

# Run entangled by default
# CMD ["entangled"]

# COPY ./init.sh /
# RUN chmod +x /init.sh
# ENTRYPOINT ["/init.sh"]
# CMD ["true"]

COPY ./init_validator.sh /
COPY ./init_validator_secondary.sh /
COPY ./init_validator_secondary2.sh /
COPY ./ent_env /
COPY ./restart_chain.sh /
COPY ./p2p_config.sh /
COPY ./add_seed.sh /
COPY ./genesis.json /
COPY ./env_seeds /
COPY ./init_seeds.sh /

RUN echo key path $key_path
RUN echo ${key_path}
COPY ${key_path} /

RUN chmod +x /init_validator.sh
ENTRYPOINT ["/init_validator.sh"]
# CMD [key_password, ip_address]


