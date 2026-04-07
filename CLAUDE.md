# runtools-sshpiper

This repo is a low-level sshpiper image/plugin fork and reference repo. Most RunTools SSH work should start in `runtools-ssh-gateway`, not here.

## Use this repo when
- debugging sshpiper core behavior
- comparing vendor-style plugin behavior with the deployed RunTools gateway
- inspecting image/build automation around `11notes/sshpiper`

## Prefer other repos for live work
- `runtools-ssh-gateway` for deployment and the real password-capable `rest_auth` plugin
- `runtools-orchestrator` for `/internal/ssh-auth` and SSH auto-resume behavior
- `runtools-fc-agent` for host routing to sandbox SSH

## Production truth
- Production deploy is owned by `runtools-orchestrator/docker-compose.yml`, which runs service `ssh-gateway` from `registry.digitalocean.com/runtools/ssh-gateway:latest`.
- `runtools-ssh-gateway/docker-compose.yml` is local/example context and still references `11notes/sshpiper`.

## Important files
- `build/go/entrypoint/main.go`
- `build/go/sshpiper/plugin/rest_auth/*`
- `build/go/sshpiper/plugin/rest_challenge/*`
- `.json`, `arch.dockerfile`, `.github/workflows/*.yml`
- `compose.yml` as example vendor compose, not live platform compose

## Repo skills
- `.claude/skills/repo-context/SKILL.md`
- `.claude/skills/ssh-plugin-contract/SKILL.md`
