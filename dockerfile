FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o main .

FROM gcr.io/distroless/base-debian11
COPY --from=builder /app/main .
COPY --from=builder app/static ./static
EXPOSE 8080
ENTRYPOINT ["/main"]

