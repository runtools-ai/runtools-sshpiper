---
name: ssh-plugin-contract
description: Use when comparing the sshpiper plugin behavior in this repo with the deployed RunTools SSH auth flow.
---

# SSH Plugin Contract

- Deployed RunTools SSH auth is split across repos:
  - `runtools-orchestrator/docker-compose.yml` owns the production `ssh-gateway` service and runs `registry.digitalocean.com/runtools/ssh-gateway:latest`
  - `runtools-ssh-gateway/docker-compose.yml` is local/example context and still runs `11notes/sshpiper`
  - `runtools-ssh-gateway/plugin/rest_auth/rest_auth.go` contains the real RunTools password-capable plugin logic
  - `runtools-orchestrator/src/routes/v1/ssh-gateway.ts` is the live SSH auth contract

- The live orchestrator contract is:
  - `GET /internal/ssh-auth/:sandboxId` -> `{ user, host, authorizedKeys, privateKey }` for public-key auth
  - `POST /internal/ssh-auth/:sandboxId/password` -> `{ allowed, user, host, privateKey, error? }` for password auth

- In this repo:
  - `build/go/sshpiper/plugin/rest_auth/main.go` exposes `REST_AUTH_URL` and `REST_AUTH_INSECURE`
  - `build/go/sshpiper/plugin/rest_auth/rest_auth.go` is upstream-style auth logic and does not implement the RunTools password POST flow
  - `build/go/sshpiper/plugin/rest_challenge/*` exists, but deployed gateway compose currently comments out `REST_CHALLENGE_URL`

- Entry-point defaults come from `build/go/entrypoint/main.go`:
  - `--server-key /run/secrets/ssh_host_key`
  - `--log-format json`
  - `--drop-hostkeys-message`
  - `--reply-ping`
  - `--port 22`
  - `DEBUG` env toggles log level to `debug`

- Sharp edge:
  - `supportedMethods()` in this repo's `rest_auth` plugin builds a map with `publickey=true` and `password=false` but then appends map keys without checking the values, so it effectively returns both method names.
  - Do not assume this repo's plugin behavior matches the deployed RunTools gateway plugin.
