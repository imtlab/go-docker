NAME = imtlab/baseimage
VERSION = 18.0.1

.PHONY: all build_all clean clean_images \
	build_golang113 \
	release test tag_latest

all: build_all

build_all: \
	build_golang113


build_golang113:
	rm -rf golang113_image
	cp -pR image golang113_image
	echo golang113=1 >> golang113_image/buildconfig
	echo final=1 >> golang113_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" golang113_image/Dockerfile
	docker build -t $(NAME)-golang:1.13-$(VERSION) --rm golang113_image

clean:
	rm -rf golang113_image

clean_images:
	@if docker images $(NAME)-golang:1.13-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-golang:1.13-$(VERSION) || true; fi

tag_latest:
	docker tag $(NAME)-golang:1.13-$(VERSION) $(NAME)-golang:latest

release: test tag_latest
	@if ! docker images $(NAME)-golang:1.13-$(VERSION) | awk '{ print $$2 }' | grep -q -F 1.13-$(VERSION); then echo "$(NAME)-golang:1.13-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-golang

test:
	@if docker images $(NAME)-golang:1.13-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-golang:1.13 GOLANG='go1.13' VERSION=$(VERSION) test/runner.sh; fi
