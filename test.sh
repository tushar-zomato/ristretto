#! /bin/sh

starttest() {
	set -e
	GO111MODULE=on go test -race ./...
}

if [ -z "${TEAMCITY_VERSION}" ]; then
	# running locally, so start test in a container
	# TEAMCITY_VERSION=local will avoid recursive calls, when it would be running in container
	docker run --rm --name ristretto-test -ti \
  		-v `pwd`:/go/src/github.com/tushar-zomato/ristretto \
  		--workdir /go/src/github.com/tushar-zomato/ristretto \
		--env TEAMCITY_VERSION=local \
  		golang:1.16 \
  		sh test.sh
else
	# running in teamcity, since teamcity itself run this in container, let's simply run this
	starttest
fi
