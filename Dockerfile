# FROM golang:stretch

# WORKDIR $GOPATH/src/github.com/pion/ion-sfu

# COPY go.mod go.sum ./
# RUN cd $GOPATH/src/github.com/pion/ion-sfu && go mod download

# COPY sfu/ $GOPATH/src/github.com/pion/ion-sfu/pkg
# COPY cmd/ $GOPATH/src/github.com/pion/ion-sfu/cmd
# COPY config.toml $GOPATH/src/github.com/pion/ion-sfu/config.toml
FROM golang:stretch

WORKDIR /ion-sfu

COPY go.mod go.sum ./
RUN go mod download

#COPY pkg/ $GOPATH/src/github.com/pion/ion-sfu/pkg
COPY pkg/ pkg/
COPY cmd/ cmd/
COPY config.toml config.toml
RUN go build ./cmd/signal/json-rpc/main.go

ENTRYPOINT [ "/ion-sfu/main" ]
CMD [ "-c", "/ion-sfu/config.toml" ]
