docker-build:
	@docker build . -t rokit/tool:latest
	@docker build . -t rokit/tool:$(shell git describe --abbrev=0 --tags)

docker-push:
	@docker push rokit/tool:latest
	@docker push rokit/tool:$(shell git describe --abbrev=0 --tags)
