FROM golang:1-alpine as golang
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk --no-cache add git zip tzdata ca-certificates
# avoid go path, use go mod
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -ldflags "-s -w -extldflags "-static"" ./cmd/appnamehere
WORKDIR /usr/share/zoneinfo
# -0 means no compression.  Needed because go's
# tz loader doesn't handle compressed data.
RUN zip -r -0 /zoneinfo.zip .

FROM scratch
# the timezone data:
ENV ZONEINFO /zoneinfo.zip
COPY --from=golang /zoneinfo.zip /
# the tls certificates:
COPY --from=golang /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
# Copy the binary
COPY --from=golang /app/appnamehere/
# example ENV: COS secret ID and secret key
ENV COS_SECRET_ID="" COS_SECRET_KEY=""
# example EXPOSE
EXPOSE 3030
ENTRYPOINT ["/appnamehere"]
