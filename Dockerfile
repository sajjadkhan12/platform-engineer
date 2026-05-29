FROM golang:1.26-alpine AS builder

WORKDIR /src
# Copy go.mod and go.sum first to leverage Docker cache for dependencies
COPY go.mod go.sum ./ 
# Download dependencies before copying the rest of the source code to optimize build times
RUN go mod download 
COPY . .
# Build the application with CGO disabled for a static binary
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main ./...

FROM scratch
COPY --from=builder /app/main /app/main
EXPOSE 8080
ENV PORT=8080
USER 1000
ENTRYPOINT ["/app/main"]
