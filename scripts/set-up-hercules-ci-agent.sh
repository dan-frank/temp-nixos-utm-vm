#!/usr/bin/env bash

install \
    --mode 0700 \
    --owner hercules-ci-agent \
    --directory \
    /var/lib/hercules-ci-agent/secrets \
    /var/lib/hercules-ci-agent/.config \
    /var/lib/hercules-ci-agent/.config/nix \
    ;

install \
    --mode 0400 \
    --owner hercules-ci-agent \
    --target-directory /var/lib/hercules-ci-agent/secrets \
    ../secrets/secrets.json \
    ../secrets/cluster-join-token.key \
    ../secrets/binary-caches.json \
    ;

# install \
#     --mode 0400 \
#     --owner hercules-ci-agent \
#     --target-directory /var/lib/hercules-ci-agent/.config/nix \
#     ../secrets/netrc \
#     ;

# install \
#     --mode 0400 \
#     --owner hercules-ci-agent \
#     <(echo 'netrc-file = /var/lib/hercules-ci-agent/.config/nix/netrc') \
#     /var/lib/hercules-ci-agent/.config/nix/nix.conf \
#     ;
