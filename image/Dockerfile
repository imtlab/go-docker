FROM imtlab/baseimage:##TAG##
LABEL maintainer="infra-ops@imtlab.io"

ENV GOPATH /go
COPY . /golang_build
RUN /golang_build/install.sh

ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
WORKDIR $GOPATH
CMD ["/sbin/my_init"]
