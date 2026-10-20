{ pkgs, lib, ... }:

{
  packages = [
    pkgs.agent-browser
    pkgs.bun
    pkgs.chromium
    pkgs.direnv
    pkgs.git
    pkgs.nodejs
  ];

  env.AGENT_BROWSER_EXECUTABLE_PATH = lib.getExe pkgs.chromium;
  env.EXPO_NO_TELEMETRY = "1";
  env.PUPPETEER_EXECUTABLE_PATH = lib.getExe pkgs.chromium;
  env.PUPPETEER_SKIP_DOWNLOAD = "1";

  git-hooks.hooks = {
    nixfmt.enable = true;

    "format-prettier" = {
      enable = true;
      name = "Prettier (bun)";
      entry = "${lib.getExe pkgs.bun} x prettier --write";
      files = "\\.(?:[cm]?[jt]sx?|json|css|md|ya?ml)$|(?:^|/)\\.prettierrc$";
      excludes = [
        "^\\.agents/"
        "^expo-env\\.d\\.ts$"
        "^uniwind-types\\.d\\.ts$"
      ];
    };

    "lint-eslint" = {
      enable = true;
      name = "ESLint (bun)";
      entry = "${lib.getExe pkgs.bun} x eslint --fix --max-warnings=0 --no-warn-ignored";
      files = "\\.(?:[cm]?[jt]sx?)$";
      excludes = [
        "^expo-env\\.d\\.ts$"
        "^uniwind-types\\.d\\.ts$"
      ];
    };

    typecheck = {
      enable = true;
      name = "TypeScript";
      entry = "${lib.getExe pkgs.bun} run typecheck";
      files = "\\.(?:[cm]?tsx?)$";
      pass_filenames = false;
    };
  };
}
