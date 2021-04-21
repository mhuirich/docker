DOCKER_ORG = mhuirich
ALPINE_VERS = 3.13.5
GHC_VERS = 8.10.4
VERS = $(GHC_VERS)-alpine$(ALPINE_VERS)

.PHONY: haskell
haskell:
	docker build ./haskell
	docker build -t $(DOCKER_ORG)/$@ ./$@
	docker tag $(DOCKER_ORG)/$@ $(DOCKER_ORG)/$@:latest
	docker tag $(DOCKER_ORG)/$@ $(DOCKER_ORG)/$@:$(VERS)

haskell-sh:
	docker run --entrypoint=sh -it $(DOCKER_ORG)/haskell:latest

ghci:
	docker run -it $(DOCKER_ORG)/haskell:latest

haskell-push:
	docker push $(DOCKER_ORG)/haskell:latest
	docker push $(DOCKER_ORG)/haskell:$(VERS)
