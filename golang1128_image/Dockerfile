FROM imtlab/baseimage:18.0.1
LABEL maintainer="infra-ops@imtlab.io"

ENV GOPATH /go
COPY . /golang_build
RUN /golang_build/install.sh

ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
WORKDIR $GOPATH
CMD ["/sbin/my_init"]
