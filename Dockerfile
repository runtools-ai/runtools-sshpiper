# =============================================================================
# RunTools SSHPiper - Fork of 11notes/sshpiper with password auth enabled
# =============================================================================

# Build stage
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git

WORKDIR /build

# Clone the upstream sshpiper
RUN git clone --depth 1 --branch v1.5.1 https://github.com/tg123/sshpiper.git /build/sshpiper

# Copy our modified rest_auth plugin
COPY build/go/sshpiper/plugin/rest_auth /build/sshpiper/plugin/rest_auth

WORKDIR /build/sshpiper

# Build sshpiperd and all plugins
RUN go mod tidy && \
    CGO_ENABLED=0 go build -tags full -ldflags="-extldflags=-static -X main.mainver=1.5.1-runtools" -o /sshpiperd ./cmd/sshpiperd && \
    CGO_ENABLED=0 go build -tags full -ldflags="-extldflags=-static" -o /rest_auth ./plugin/rest_auth

# Runtime stage
FROM alpine:3.20

RUN apk add --no-cache ca-certificates

# Create non-root user
RUN adduser -D -u 1000 sshpiper

WORKDIR /app

# Copy binaries from builder
COPY --from=builder /sshpiperd /app/sshpiperd
COPY --from=builder /rest_auth /app/rest_auth

# Create directories
RUN mkdir -p /app/var && chown -R sshpiper:sshpiper /app

USER sshpiper

# Health check
HEALTHCHECK --interval=5s --timeout=2s --start-period=5s \
    CMD nc -z 127.0.0.1 22 || exit 1

EXPOSE 22

# Default entrypoint - runs rest_auth plugin
ENTRYPOINT ["/app/sshpiperd"]
CMD ["/app/rest_auth", "--url", "http://orchestrator:8080/internal/ssh-auth"]
