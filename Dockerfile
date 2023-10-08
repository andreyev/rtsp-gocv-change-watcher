FROM golang:latest AS build
ENV GOPROXY direct
WORKDIR /app
COPY go.mod main.go .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /rtsp-gocv-change-watcher

FROM scratch 
COPY --from=build /rtsp-gocv-change-watcher /
EXPOSE 8080
ENTRYPOINT ["/rtsp-gocv-change-watcher"]
