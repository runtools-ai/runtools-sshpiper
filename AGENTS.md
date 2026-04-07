# runtools-sshpiper

This repo is a low-level sshpiper image/plugin fork and reference repo. It is not the normal starting point for RunTools SSH work.

## Use this repo when
- debugging sshpiper core behavior
- checking how the upstream-style Go plugins behave
- comparing vendor image/build behavior with the deployed RunTools gateway

## Prefer other repos for live platform work
- `runtools-ssh-gateway` for the deployed compose, env wiring, and the real password-capable `rest_auth` plugin
- `runtools-orchestrator` for `/internal/ssh-auth` contract and sandbox auto-resume behavior
- `runtools-fc-agent` for DNAT, host routing, and VM SSH reachability

## Important files
- `build/go/entrypoint/main.go`: default `sshpiperd` flags and entrypoint behavior
- `build/go/sshpiper/plugin/rest_auth/*`: upstream-style REST auth plugin in this fork
- `build/go/sshpiper/plugin/rest_challenge/*`: optional keyboard-interactive challenge plugin
- `.json`, `arch.dockerfile`, `.github/workflows/*.yml`: vendor image metadata and automation
- `compose.yml`: example compose for the vendor image, not the live RunTools gateway deployment

## Current RunTools reality
- Production deploy is owned by `runtools-orchestrator/docker-compose.yml`, which runs service `ssh-gateway` from `registry.digitalocean.com/runtools/ssh-gateway:latest`.
- `runtools-ssh-gateway/docker-compose.yml` is local/example context and still references `11notes/sshpiper`.
- The real RunTools password-auth support lives in `runtools-ssh-gateway/plugin/rest_auth/rest_auth.go`.
- This repo is best treated as upstream/reference material unless you are intentionally changing the container image internals.

## Repo skills
- `.agents/skills/repo-context/SKILL.md`
- `.agents/skills/ssh-plugin-contract/SKILL.md`
