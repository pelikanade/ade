# ade

Expo + React Native app scaffolded with [React Native Reusables](https://reactnativereusables.com) and [Uniwind](https://uniwind.dev).

## Stack

- Expo SDK 57, React Native 0.86, Expo Router
- React 19
- Bun workspace monorepo
- Tailwind CSS 4 via Uniwind (no Babel preset)
- React Native Reusables (shadcn-style components, `@rn-primitives`)
- Zod
- TanStack Query
- Zustand for local state
- ESLint 10 with `typescript-eslint` strict, `@eslint-react` strict TypeScript, React Hooks, and a local `no-comments` rule

## Development environment

Runtime versions are pinned with [devenv](https://devenv.sh): Bun 1.4.2, Node.js 24, Chromium, `agent-browser`, and Puppeteer.
direnv activates the shell automatically where installed. Both browser tools point at the pinned Nix Chromium via
`AGENT_BROWSER_EXECUTABLE_PATH` and `PUPPETEER_EXECUTABLE_PATH`, so no browser is downloaded.
Workspace installs use Bun's hoisted linker (`bunfig.toml`) to keep Expo native modules deduplicated.

```sh
devenv shell       # or: direnv allow .
bun install
bun dev            # Expo dev server
bun run web        # web
bun run android    # Android
bun run ios        # iOS (macOS)
bun run format     # Prettier write
bun run format:check
bun run lint
bun run typecheck
```

`devenv shell` installs git hooks from [git-hooks.nix](https://github.com/cachix/git-hooks.nix). The
pre-commit hook formats staged files with Prettier (via Bun), fixes and checks them with ESLint,
formats Nix files, and runs the full TypeScript check. Run all hooks manually with
`prek run --all-files`.

## Project layout

- `apps/app/` — Expo app workspace
- `apps/app/app/` — Expo Router routes; `_layout.tsx` owns providers (Uniwind theme, navigation, TanStack Query, portal host)
- `apps/app/components/ui/` — Reusables components
- `apps/app/global.css` — Tailwind 4 theme tokens consumed by Uniwind
- `apps/app/lib/query-client.ts` — shared `QueryClient`
- `eslint.config.mjs` — flat config plus the inline `local/no-comments` rule
- `.agents/skills/devenv/SKILL.md` — devenv workflow reference

Add more components with:

```sh
cd apps/app
bunx @react-native-reusables/cli@latest add [components]
```
