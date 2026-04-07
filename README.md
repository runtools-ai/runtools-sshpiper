# runtools-sshpiper

This repo is a low-level reference fork around the `11notes/sshpiper` image and sshpiper plugin internals. It is not the main RunTools SSH deployment repo.

## What this repo contains

- `build/go/entrypoint/main.go`
  - wrapper entrypoint that launches `sshpiperd`
  - default flags:
    - `--server-key /run/secrets/ssh_host_key`
    - `--log-format json`
    - `--drop-hostkeys-message`
    - `--reply-ping`
    - `--port 22`
  - `DEBUG` switches log level from `info` to `debug`

- `build/go/sshpiper/plugin/rest_auth/*`
  - upstream-style REST auth plugin
  - exposes `REST_AUTH_URL` and `REST_AUTH_INSECURE`

- `build/go/sshpiper/plugin/rest_challenge/*`
  - optional keyboard-interactive challenge plugin
  - exposes `REST_CHALLENGE_URL` and `REST_CHALLENGE_INSECURE`

- `.json`, `arch.dockerfile`, `.github/workflows/*.yml`
  - vendor image metadata and automated multi-arch build/version workflows

- `compose.yml`
  - example compose for the vendor image
  - not the live RunTools SSH gateway deployment

## Important RunTools context

- Production deploy is owned by [runtools-orchestrator/docker-compose.yml](C:/Users/wgtgr/OneDrive/Desktop/Repositories/RUNTOOLS/runtools-orchestrator/docker-compose.yml), which runs service `ssh-gateway` from `registry.digitalocean.com/runtools/ssh-gateway:latest`.
- [runtools-ssh-gateway/docker-compose.yml](C:/Users/wgtgr/OneDrive/Desktop/Repositories/RUNTOOLS/runtools-ssh-gateway/docker-compose.yml) is local/example context and still references `11notes/sshpiper`.
- The real RunTools password-capable `rest_auth` plugin lives in [rest_auth.go](C:/Users/wgtgr/OneDrive/Desktop/Repositories/RUNTOOLS/runtools-ssh-gateway/plugin/rest_auth/rest_auth.go).
- The live SSH auth contract lives in [ssh-gateway.ts](C:/Users/wgtgr/OneDrive/Desktop/Repositories/RUNTOOLS/runtools-orchestrator/src/routes/v1/ssh-gateway.ts).

## When to use this repo

- debugging sshpiper internals
- comparing vendor plugin behavior with deployed RunTools behavior
- changing the container/image build pipeline around `11notes/sshpiper`

## When not to use this repo

- normal SSH gateway deploy changes: use `runtools-ssh-gateway`
- SSH auth contract changes: use `runtools-orchestrator`
- VM routing, DNAT, and host SSH plumbing: use `runtools-fc-agent`
