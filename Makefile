SHELL := /bin/bash

compiler: compiler.Dockerfile
	docker build --platform linux/amd64 -f ${PWD}/compiler.Dockerfile -t jeylabs/poppler/compiler:latest .

build: compiler
	docker build --platform linux/amd64 --no-cache -f ${PWD}/builder.Dockerfile -t jeylabs/poppler:latest .

distribution: build
	docker run --rm \
		--platform linux/amd64 \
		--env ZIP_FILE_NAME=poppler \
		--volume ${PWD}/export:/export \
		--volume ${PWD}/runtime:/runtime \
		--volume ${PWD}/export.sh:/export.sh:ro \
		jeylabs/poppler:latest \
		/export.sh
