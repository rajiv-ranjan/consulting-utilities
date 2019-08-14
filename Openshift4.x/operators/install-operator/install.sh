#! /bin/bash

echo "---> Release version v0.10.0 used."
CURRENT_DIR=`pwd`
TEMP_DIR="/tmp"
cd ${TEMP_DIR}
RELEASE_VERSION=v0.10.0
curl -OJL https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-apple-darwin
echo "Downloaded the binary"

echo "---> Verify the download"
gpg --recv-keys "0CF50BEE7E4DF6445E08C0EA9AFDE59E90D2B445"
curl -OJL https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-apple-darwin.asc
gpg --verify operator-sdk-${RELEASE_VERSION}-x86_64-apple-darwin.asc

echo "---> Install the binary"
chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-apple-darwin \
  && sudo mkdir -p /usr/local/bin/ \
  && sudo cp operator-sdk-${RELEASE_VERSION}-x86_64-apple-darwin /usr/local/bin/operator-sdk \
  && rm operator-sdk-${RELEASE_VERSION}-x86_64-apple-darwin

echo "---> Verify the version"
cd ${CURRENT_DIR}
operator-sdk version