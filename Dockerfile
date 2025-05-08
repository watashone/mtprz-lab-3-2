# Етап збірки
FROM golang:1.21 AS builder

WORKDIR /app
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main .

# Фінальний етап
FROM gcr.io/distroless/static-debian12

COPY --from=builder /app/main /main

CMD ["/main"]