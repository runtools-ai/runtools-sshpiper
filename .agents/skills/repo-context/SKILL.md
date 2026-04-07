---
name: repo-context
description: Use when working on low-level sshpiper behavior, image internals, or comparing this fork with the deployed RunTools SSH gateway.
---

# runtools-sshpiper Repo Context

- Purpose: low-level sshpiper fork/reference repo plus vendor image automation.
- This is not the normal RunTools SSH integration repo. Start in `runtools-ssh-gateway` unless you need to debug image/plugin internals.
- Key code lives under:
  - `build/go/entrypoint/main.go`
  - `build/go/sshpiper/plugin/rest_auth/*`
  - `build/go/sshpiper/plugin/rest_challenge/*`
- Production deploy is owned by `runtools-orchestrator/docker-compose.yml` -> service `ssh-gateway` -> `registry.digitalocean.com/runtools/ssh-gateway:latest`.
- `runtools-ssh-gateway/docker-compose.yml` is local/example context and still references `11notes/sshpiper`.
- `compose.yml` here is an upstream/example compose, not the production RunTools gateway compose.
- `.json`, `arch.dockerfile`, and `.github/workflows/*.yml` drive vendor-style image versioning and build automation.
- For normal platform SSH changes, prefer:
  - `runtools-ssh-gateway` for deployment, env wiring, and the real password-capable `rest_auth` plugin
  - `runtools-orchestrator` for `/internal/ssh-auth`
  - `runtools-fc-agent` for host-to-VM SSH routing
