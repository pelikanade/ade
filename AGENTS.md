# AGENTS.md

> Status: updated 2026-10-20 after the initial scaffold. It records only the decisions Noa has made explicitly. Anything not written here is undecided: ask Noa before you pick a library, tool, layout or convention that isn't listed.

## What this is

`ade` (working name; the real name comes later) is an agentic development environment built around **one persistent coordinating agent per project**. That agent:

- has memory
- accepts input from many channels
- works on the project persistently
- dispatches sub-agents to push the work forward

Product shape:

- **Self-hosted daemon.** It runs on the user's own computer or server, and the app connects to it remotely. A hosted cloud version comes later.
- **One React Native app** for mobile, web and desktop.
- **External product from day one:** multi-user, onboarding, public release.
- **Closed source for now.** License later.

## Technical decisions

- **Repository layout:** Bun workspace monorepo with `apps/app`, `apps/daemon` and `packages/protocol`, sharing one root lockfile.
- **Agent runtime:** omp (oh-my-pi) only, for both the coordinator and sub-agents.
- **Daemon:** TypeScript. It shares one zod protocol package with the app.
- **App:** React Native with Expo Router.
- **Styling and components:** Uniwind plus React Native Reusables, using Reusables' Uniwind component source.
- **State:** zustand for local state; TanStack Query for server state.
- **Testing:** E2E tests run through `agent-browser`.
- **Formatting:** Prettier, executed with Bun.
- **Lint:** ESLint with `tseslint.configs.strict`.

## Pre-bootstrap mode

**Bootstrap** means one straight week of developing ade using only ade. Until then:

- **Memory:** nowledge mem only.
- **Input:** the coordinator takes input only through in-app chat.
- **Merging:** the coordinator may merge its own PRs once CI and review have passed.
- **Connectivity:** the app connects to the daemon directly (LAN or Tailscale) and pairs by scanning a QR code with a pairing token. An E2EE relay comes later.

Revisit at bootstrap: the memory backend for other users, other input channels, the E2EE relay, and whether merging goes back to humans only.

## Basic rules

- **Atomic commits.** Each commit is one logical change that builds and passes its checks on its own. Don't mix refactors, formatting and behavior changes in one commit; split them.
- **Autonomous commits.** Commit completed, passing work at appropriate logical boundaries without waiting for an explicit request.
- **Native dependencies go through devenv.** When a task needs a native tool, system library or toolchain, follow the devenv skill in this repo and declare it in the devenv config. Don't install it globally or by hand, and don't assume it is already on the machine.
- **Pre-commit checks.** Every commit passes the repo's pre-commit hooks. Never skip them with `--no-verify` or disable a hook to get a commit through; fix the cause.

## Open

Product name, git remote and license are undecided. CI is deferred until a remote exists.
