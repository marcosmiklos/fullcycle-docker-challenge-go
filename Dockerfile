FROM golang:1.15-alpine AS builder

WORKDIR /app
COPY hellofullcycle.go /app
RUN apk add upx
RUN go build -ldflags "-s -w" -o hellofullcycle .
RUN upx --brute hellofullcycle

FROM scratch
COPY --from=builder /app/hellofullcycle /
ENTRYPOINT [ "/hellofullcycle" ] 
