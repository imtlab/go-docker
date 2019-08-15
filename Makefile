NAME = imtlab/baseimage
VERSION = 18.0.1

.PHONY: all build_all clean clean_images \
	build_golang1115 \
	build_golang112 \
	build_golang112 \
	release test tag_latest

all: build_all

build_all: \
	build_golang1115
	build_golang112
	build_golang1128

build_golang1115:
	rm -rf golang1115_image
	cp -pR image golang1115_image
	echo golang1115=1 >> golang1115_image/buildconfig
	echo final=1 >> golang1115_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" golang1115_image/Dockerfile
	docker build -t $(NAME)-golang:1.11.5-$(VERSION) --rm golang1115_image

build_golang112:
	rm -rf golang112_image
	cp -pR image golang112_image
	echo golang112=1 >> golang112_image/buildconfig
	echo final=1 >> golang112_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" golang112_image/Dockerfile
	docker build -t $(NAME)-golang:1.12-$(VERSION) --rm golang112_image

build_golang1128:
	rm -rf golang1128_image
	cp -pR image golang1128_image
	echo golang1128=1 >> golang1128_image/buildconfig
	echo final=1 >> golang1128_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" golang1128_image/Dockerfile
	docker build -t $(NAME)-golang:1.12.8-$(VERSION) --rm golang1128_image

clean:
	rm -rf golang1115_image
	rm -rf golang112_image
	rm -rf golang1128_image

clean_images:
	@if docker images $(NAME)-golang:1.11.5-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-golang:1.11.5-$(VERSION) || true; fi
	@if docker images $(NAME)-golang:1.12-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-golang:1.12-$(VERSION) || true; fi
	@if docker images $(NAME)-golang:1.12.8-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-golang:1.12.8-$(VERSION) || true; fi

tag_latest:
	docker tag $(NAME)-golang:1.12.8-$(VERSION) $(NAME)-golang:latest

release: test tag_latest
	@if ! docker images $(NAME)-golang:1.11.5-$(VERSION) | awk '{ print $$2 }' | grep -q -F 1.11.5-$(VERSION); then echo "$(NAME)-golang:1.11.5-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-golang:1.12-$(VERSION) | awk '{ print $$2 }' | grep -q -F 1.12-$(VERSION); then echo "$(NAME)-golang:1.12-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-golang:1.12.8-$(VERSION) | awk '{ print $$2 }' | grep -q -F 1.12.8-$(VERSION); then echo "$(NAME)-golang:1.12.8-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-golang

test:
	@if docker images $(NAME)-golang:1.11.5-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-golang:1.11.5 GOLANG='go1.11.5' VERSION=$(VERSION) test/runner.sh; fi
	@if docker images $(NAME)-golang:1.12-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-golang:1.12 GOLANG='go1.12' VERSION=$(VERSION) test/runner.sh; fi
	@if docker images $(NAME)-golang:1.12.8-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-golang:1.12.8 GOLANG='go1.12.8' VERSION=$(VERSION) test/runner.sh; fi
