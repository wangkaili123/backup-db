# build stage(Only for server)
FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct \
    && go get -d -v . \
    && go install -v . \
    && go build -v .

# final stage, build server
FROM golang:alpine
WORKDIR /app
ENV TZ=Asia/Shanghai
COPY --from=builder /app/backup-db /app/backup-db
ENTRYPOINT /app/backup-db
LABEL Name=backup-db-server Version=1.0.0
